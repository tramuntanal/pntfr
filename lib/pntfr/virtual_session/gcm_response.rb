#
# Google Cloud Messaging json response wrapper.
#
require 'pntfr/virtual_session/base_response'
require 'json'

module Pntfr
  module VirtualSession
    class GcmResponse < BaseResponse
      def initialize json
        @raw= json
        @status_code= @raw[:status_code]
        @response= @raw[:response]
        @body= @raw[:body]
        if success?
          @parsed_body= JSON.parse(@body)
          @body_result= @parsed_body['results'].first
        end
      end
      def success?
        @status_code == 200
      end
      def bad_sender_account?
        @status_code == 401
      end
      def failure?
        @status_code == 400 or @status_code >= 500
      end
      def msg_sent?
        success? && @parsed_body['success'] == 1
      end
      def error?
        success? and !msg_sent? and @body_result.has_key?('error')
      end
      def error
        if error?
          @body_result['error']
        end
      end
      def failure
        "#{@body}->#{@response}"
      end
      def to_s
        @raw.to_s
      end
    end
  end
end
