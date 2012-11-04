require 'action_view'
require 'rspec/v150/view'
module RSpec::V150
  module View
    class ErbView
      Erubis = ActionView::Template::Handlers::Erubis

      def render(path)
        self.template = path
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
