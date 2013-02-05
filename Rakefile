require 'rake'
require 'rake/testtask'
require "bundler/gem_tasks"
require 'rspec'
require 'rspec/core/rake_task'
require File.absolute_path('../spec/support/multiple_rails_version_spec_runner.rb', __FILE__)

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  # t.ruby_opts = %w[-w]
  t.rspec_opts = %w[--color]
end

desc "Run RSpec for rails version: #{MultipleRailsVersionSpecRunner::RAILS_VERSIONS.join(', ')} "
task(:spec_all_rails_versions) do |t|
  MultipleRailsVersionSpecRunner.new(ARGV).run
end

task :default => :spec
