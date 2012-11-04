require 'action_view'

module RSpec
  module V150
    module View
      def view
        @_view ||= ErbView.new
      end

      def render
        @rendered = view.render
      end

      def rendered
        @rendered
      end

      def template
        example.example_group.top_level_description
      end

      def assign(name, variable)
        view.assign(name, variable)
      end

      private

      class ErbView
        Erubis = ActionView::Template::Handlers::Erubis

        def render
          view.result(binding())
        end

        def view
          Erubis.new(template)
        end

        # def template

        # end

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
