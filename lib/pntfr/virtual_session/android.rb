#
# VirtualSession implementation for Android
#
require 'gcm'
module Pntfr
  module VirtualSession
    class Android < Pntfr::VirtualSession::Base
      FILE_EXTENSION_REGEXP= /(\.[^\.]+)\z/

      def initialize session
        super
        @notification_key= Pntfr.config.gcm[:notification_key]
        @gcm= ::GCM.new(@notification_key) unless Pntfr.test_env?
      end

      def msg content
        @data= {
          :title        => content[:title],
          :description  => content[:description],
        }
        @data[:sound]= parse_sound_file(content[:sound]) unless content[:sound].nil?
        self
      end
      def notify
        options = {data: @data}
        if Pntfr.test_env?
          Pntfr.add_delivery(@push_id, options)
          VirtualSession::SuccessResponse.new
        else
          rs= @gcm.send_notification([@push_id], options)
          parse_response rs
        end
      end

      #---------------------------------------------------------
      private
      #---------------------------------------------------------
      def parse_response rs
        VirtualSession::GcmResponse.new(rs)
      end

      def parse_sound_file filename
        filename.gsub(FILE_EXTENSION_REGEXP, '')
      end
    end
  end
end
