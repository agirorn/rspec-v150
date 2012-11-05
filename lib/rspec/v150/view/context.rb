module RSpec::V150::View
    class Context
      include ActionView::Helpers
      include ActionView::Helpers::CaptureHelper

      def _render_view(view)
        view.result(binding())
      end

      def assign(name, variable)
        instance_variable_set("@#{name}".to_sym, variable)
      end

      def output_buffer
        @output_buffer ||= ActionView::OutputBuffer.new
      end
    end
end
