#
# Session implementation for Android
#
require 'gcm'
module Pntfr
  module Session
    class Android < Pntfr::Session::Base

      attr_reader :gcm

      def initialize notification_key=nil
        if notification_key.nil?
          notification_key= Pntfr.config.gcm[:notification_key]
        end
        @gcm= ::GCM.new(notification_key)
      end

      def notify(push_ids, data)
        options = {data: data}
        if Pntfr.test_env?
          push_ids.each { |push_id| Pntfr.add_delivery(push_id, options) }
          Session::SuccessResponse.new
        else
          rs= @gcm.send_notification(push_ids, options)
          parse_response rs
        end
      end

      #---------------------------------------------------------
      private
      #---------------------------------------------------------
      def parse_response rs
        Session::GcmResponse.new(rs)
      end

    end
  end
end
