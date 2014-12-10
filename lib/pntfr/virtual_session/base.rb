module Pntfr
  module VirtualSession
    class Base
      def initialize session
        @session= session
        @push_id= @session.push_id
      end
      def msg content
        raise 'not implemented!'
      end
    end
  end
end
require 'pntfr/virtual_session/success_response'
require 'pntfr/virtual_session/android'
require 'pntfr/virtual_session/gcm_response'
require 'pntfr/virtual_session/ios'