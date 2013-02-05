class MultipleRailsVersionSpecRunner
  EMPTY_LINE = ""
  RAILS_VERSIONS = [
    "3.2.11",
    "3.1.10",
    "3.0.20",
    "3.0.19"
  ]

  attr :argv
  def initialize(argv)
    @argv = argv
  end

  def run
    RAILS_VERSIONS.each do |version|
      print_header_for version
      run_spec_for version
      print_empty_line
    end
  end

  private

  # Go to rubygems and get the latest gems from ther if -r.
  def local
    return '' if argv.include?("-r")
    '--local'
  end

  # print extra stuff.
  def verbose
    return '' if argv.include?("-V")
    "> /dev/null"
  end

  def print_empty_line
    puts EMPTY_LINE
  end

  def print_header_for(version)
    puts "#"*80, "# Running spec for rails version : #{version}", "#"*80
  end

  def print_error_for(version)
    puts [
      "!"*80,
      "! Error in Test.",
      "!",
      "! To rerun this Version do:",
      "!   #{rspec_command_for version}",
      "!",
      "!"*80
    ]
  end

  def run_spec_for version
    unless system command_for(version)
      print_error_for version
      exit!
    end
  end

  def rspec_command_for(version)
    "RAILS_VERSION='#{version}' bundle exec rspec"
  end

  def command_for(version)
    [
    "rm Gemfile.lock",
    "RAILS_VERSION='#{version}' bundle install #{local} #{verbose}",
    rspec_command_for(version)
    ].join(" && ")
  end

end


