require 'capybara'
require 'action_view'
require 'rspec/v150/view/context'

module RSpec::V150
  module View
    ERB = ActionView::Template::Handlers::Erubis

    attr_reader :template

    def view
      @view ||= Context.new
    end

    def render
      @rendered = view._render_view( ERB.new template_source )
    end

    def template_source
      File.readlines( template_path ).join
    end

    def rendered
      @rendered
    end

    def page
      Capybara.string rendered
    end

    def template=(location)
      @template = location
    end

    def assign(name, variable)
      view.assign(name, variable)
    end

    def template_path
      File.join [template_directory, template_name]
    end

  private

    def with_sufix(name)
      if name.match(/.*\.html\.erb/)
        name
      else
        name + '.html.erb'
      end
    end

    def template_directory
      'app/views/'
    end

    def default_template
      example.example_group.top_level_description
    end

    def template_name
     if template
        with_sufix @template
     else
        with_sufix default_template
     end
    end
  end
end
