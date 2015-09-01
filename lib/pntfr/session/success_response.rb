#
# Always success.
# To be used on cases where no response to be parsed is received.
#
require 'pntfr/session/base_response'

module Pntfr
  module Session
    class SuccessResponse < BaseResponse
      # communication with notification service was OK?
      # implies no +failure?+
      def success?
        true
      end
      # message has been sent?
      def msg_sent?
        true
      end
      # communication with notification service failed?
      # implies no +succcess?+
      def failure?
        false
      end
      # Was there an error with the notification?
      # implies +succcess?+ but no +msg_sent?+
      def error?
        false
      end
    end
  end
end
