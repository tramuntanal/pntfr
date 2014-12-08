
module Pntfr
  module VirtualSession
    class IosBadgeTest < Minitest::Test
      def test_sending_a_notification_increments_session_notifications_num
        clazz= Struct.new(:platform, :push_id, :num_notifs)
        session= clazz.new(Pntfr::Platforms::IOS, '1id2id3id4id5id', 0)

        Pntfr::Notifier.to(session).msg({:title => 't', :description => 'd'}).notify

        notifs= Pntfr.deliveries['1id2id3id4id5id']
        notif= notifs.last
        assert_equal 1, notif[:badge]
        assert_equal 1, session.num_notifs
      end
    end
  end
end
