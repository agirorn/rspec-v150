#
# Utility used to detect Actionpack Version and othe thins that cant be placed
# in other modules.
#
module RSpec
  module V150
    module Utility
      module ClassMethods
        def action_pack_version?(version)
          major, minor, tiny = version.split('.')
          if major == action_pack_major
            if minor == action_pack_minor
              return true
            end
          end
          return false
        end

        private

        def action_pack_major
          ActionPack::VERSION::MAJOR.to_s
        end

        def action_pack_minor
          ActionPack::VERSION::MINOR.to_s
        end
      end

      class << self; include ClassMethods; end
    end
  end
end
