require 'rspec/v150/view/erb_view'

module RSpec::V150
  module View
    def view
      @view ||= ErbView.new
    end

    def render
      view.template = template
      @rendered = view.render(template)
    end

    def rendered
      @rendered
    end

    def template
      File.join [template_path, with_sufix(_template_name)]
    end

    def template=(location)
      @template = location
    end

    def assign(name, variable)
      view.assign(name, variable)
    end

    private

    def with_sufix(name)
      if name.match(/.*\.html\.erb/)
        name
      else
        name + '.html.erb'
      end
    end

    def template_path
      'app/views/'
    end

    def _default_template
      example.example_group.top_level_description
    end

    def _template_name
      if @template
        @template
      else
        _default_template
      end
    end
  end
end
