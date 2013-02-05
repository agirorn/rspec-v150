require 'action_view'
require "rspec/v150/view"
require "rspec/v150/utility"

require "rspec/v150/view/action_pack_3_0_patch" if RSpec::V150::Utility.action_pack_version?('3.0')

module RSpec
  module V150
    module View
      class Context
        include ActionView::Helpers
        include ActionView::Helpers::CaptureHelper

        def image_tag(sourse, options = {});
          options.merge! :src => sourse
          attributes = options.collect{|k,v| "#{k}='#{v}'" }.join(' ')

          "<img #{attributes}>".html_safe
        end

        def _render_view(view)
          view.result(binding())
        end

        def assign(name, variable)
          instance_variable_set("@#{name}".to_sym, variable)
        end

        def output_buffer
          @output_buffer ||= ActionView::OutputBuffer.new
        end

        def output_buffer=(buffer)
          @output_buffer = buffer
        end
      end
    end
  end
end
