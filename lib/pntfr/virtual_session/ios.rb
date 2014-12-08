#
# VirtualSession implementation for iOS
#
module Pntfr
  module VirtualSession
    class Ios < Pntfr::VirtualSession::Base
      def msg content
        @alert= content[:title]
        @alert+= "\n#{content[:description]}"
        @sound= content[:sound]
        badge= content[:badge]
        @badge= content[:badge].to_i if badge
        self
      end

      def notify
        n= {:alert => @alert, :sound => 'default'}
        if @badge
          n[:badge]= @badge
        elsif @session.methods.include?(:num_notifs)
          @session.num_notifs+= 1
          n[:badge]= @session.num_notifs
        end
        n[:sound]= @sound if @sound

        if Pntfr.test_env?
          Pntfr.add_delivery(@push_id, n)
        else
          APNS.send_notification(@push_id, n)
        end

      end
    end
  end
end