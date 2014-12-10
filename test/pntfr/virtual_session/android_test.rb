require 'pntfr/device_session'
module Pntfr
  module VirtualSession
    class AndroidTest < Minitest::Test

      def test_received_content_shoud_be_sent_to_gcm
        push_id= 'ANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROID'
        session= DeviceSession.new(Pntfr::Platforms::ANDROID, push_id)

        vsession= Pntfr::Notifier.to(session).msg({
            :title => 'Some Title', :description => 'A description',
            :sound => 'bell.caff'
          })
        rs= vsession.notify
        assert rs.success? and rs.msg_sent?

        notifs= Pntfr.deliveries[push_id]
        refute_nil notifs, "A notification should have been delivered for #{push_id}"
        notif= notifs.last
        assert_equal 'Some Title', notif[:data][:title]
        assert_equal 'A description', notif[:data][:description]
        assert_equal 'bell', notif[:data][:sound]
      end
      def test_sound_attribute_shoud_be_sent_to_gcm
        push_id= 'ANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROID'
        session= DeviceSession.new(Pntfr::Platforms::ANDROID, push_id)

        vsession= Pntfr::Notifier.to(session).msg({
            :title => 'Some Title', :description => 'A description',
            :sound => 'bell.caff'
          })
        rs= vsession.notify
        assert rs.success? and rs.msg_sent?

        notifs= Pntfr.deliveries[push_id]
        refute_nil notifs, "A notification should have been delivered for #{push_id}"
        notif= notifs.last
        assert_equal 'Some Title', notif[:data][:title]
        assert_equal 'A description', notif[:data][:description]
        assert_equal 'bell', notif[:data][:sound]
      end
    end
  end
end
