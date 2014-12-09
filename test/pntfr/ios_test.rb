module Pntfr
  module VirtualSession
    class IosTest < Minitest::Test
      def test_ios_information_from_previous_msg_should_be_reset_when_sending_a_new_msg
        session= IosDeviceSession.new(Pntfr::Platforms::IOS, name, 3)
        vsession= Pntfr::Notifier.to(session)

        vsession.msg(title: 't1', description: 'd1', sound: 's1').notify
        vsession.msg(title: 't2', description: 'd2').notify

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
