require 'pntfr/device_session'
module Pntfr
  module VirtualSession
    class IosTest < Minitest::Test

      def test_received_content_shoud_be_ready_to_be_sent_to_apns
        push_id= 'IOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSios'
        session= DeviceSession.new(Pntfr::Platforms::IOS, push_id)

        rs= Pntfr::Notifier.to(session).msg({:title => 'thatitle', :description => 'thadescription', :sound => 'click.aiff', :badge => 33}).notify
        assert rs.success? and rs.msg_sent?

        ios_notifs= Pntfr.deliveries[push_id]
        refute_nil ios_notifs, "A notification should have been delivered for #{push_id}"
        ios_notif= ios_notifs.last
        assert_equal "thatitle\nthadescription", ios_notif[:alert]
        assert_equal 'click.aiff', ios_notif[:sound]
        assert_equal 33, ios_notif[:badge]
      end

      def test_ios_information_from_previous_msg_should_be_reset_when_sending_a_new_msg
        session= IosDeviceSession.new(Pntfr::Platforms::IOS, name, 3)
        vsession= Pntfr::Notifier.to(session)

        rs= vsession.msg(title: 't1', description: 'd1', sound: 's1').notify
        assert rs.success? and rs.msg_sent?
        rs= vsession.msg(title: 't2', description: 'd2').notify
        assert rs.success? and rs.msg_sent?

        notifs= Pntfr.deliveries[session.push_id]
        assert_equal 5, session.num_notifs
        assert_equal 2, notifs.size
        notif= notifs.first
        assert_equal "t1\nd1", notif[:alert]
        assert_equal 's1', notif[:sound]
        assert_equal 4, notif[:badge]
        notif= notifs.last
        assert_equal "t2\nd2", notif[:alert]
        assert_equal 'default', notif[:sound]
        assert_equal 5, notif[:badge]
      end
    end
  end
end
