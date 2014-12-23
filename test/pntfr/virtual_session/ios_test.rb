require 'pntfr/device_session'
module Pntfr
  module VirtualSession
    class IosTest < Minitest::Test
      def setup
        @push_id= 'IOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSios'
      end

      def test_received_content_shoud_be_ready_to_be_sent_to_apns
        session= DeviceSession.new(Pntfr::Platforms::IOS, @push_id)

        rs= Pntfr::Notifier.to(session).msg({:title => 'thatitle', :description => 'thadescription', :sound => 'click.aiff', :badge => 33}).notify
        assert rs.success? and rs.msg_sent?

        ios_notifs= Pntfr.deliveries[@push_id]
        refute_nil ios_notifs, "A notification should have been delivered for #{@push_id}"
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

      def test_sending_custom_content_for_ios_should_be_added_as_acme_keys
        session= DeviceSession.new(Pntfr::Platforms::IOS, @push_id)

        vsession= Pntfr::Notifier.to(session)
        vsession.msg(Fxtr::Common.simple_msg, Fxtr::Common.custom_msg_content)
        rs= vsession.notify
        assert rs.success? and rs.msg_sent?

        ios_notifs= Pntfr.deliveries[@push_id]
        refute_nil ios_notifs, "A notification should have been delivered for #{@push_id}"
        ios_notif= ios_notifs.last
        assert_equal 'Test Title', ios_notif[:alert]
        assert_equal 'extra one', ios_notif[:'acme-extra1']
        assert_equal 'extra 2', ios_notif[:'acme-extra_2']
        assert_equal({lastkey: 'last value'}, ios_notif[:'acme-last-extra'])
      end
    end
  end
end
