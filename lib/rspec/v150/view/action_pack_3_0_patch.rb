#
# Patch for ActionPack 3.0
#
module ActionView
  # = Action View Capture Helper
  module Helpers
    module CaptureHelper
      class NonConcattingString < ActiveSupport::SafeBuffer
      end
    end
  end
end

