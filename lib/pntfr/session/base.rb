module Pntfr
  module Session
    class Base
      def initialize devices
        @devices= devices
      end
      def msg content
        raise 'not implemented!'
      end
      def notify(push_ids, data)
        raise 'not implemented!'
      end
    end
  end
end
require 'pntfr/session/success_response'
require 'pntfr/session/android'
require 'pntfr/session/gcm_response'
require 'pntfr/session/ios'