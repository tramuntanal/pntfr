module Pntfr
  module VirtualSession
    class BaseResponse
      # communication with notification service was OK?
      # implies no +failure?+
      def success?
        raise 'not implemented!'
      end
      # message has been sent?
      def msg_sent?
        raise 'not implemented!'
      end
      # communication with notification service failed?
      # implies no +succcess?+
      def failure?
        raise 'not implemented!'
      end
      # Was there an error with the notification?
      # implies +succcess?+ but no +msg_sent?+
      def error?
        raise 'not implemented!'
      end
      # which was the error?
      def error
      end
      # which was the failure?
      def failure
      end
    end
  end
end
