require 'action_view'

module RSpec
  module V150
    module View
      def view
        @_view ||= ErbView.new
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

      class ErbView
        Erubis = ActionView::Template::Handlers::Erubis

        def render(path)
          template = path
          view.result(binding())
        end

        def view
          Erubis.new(template)
        end

        def template
          File.readlines(@template).join()
        end

        def template=(value)
          @template = value
        end

        def output_buffer
          @output_buffer ||= ActionView::OutputBuffer.new
        end

        def assign(name, variable)
          instance_variable_set("@#{name}".to_sym, variable)
        end
      end
    end
  end
end
