require 'pntfr/device_session'
require 'fxtr'

module Pntfr
  module VirtualSession
    class AndroidTest < Minitest::Test

      def setup
        @push_id= 'ANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROID'
      end
      def test_received_content_shoud_be_sent_to_gcm
        session= DeviceSession.new(Pntfr::Platforms::ANDROID, @push_id)

        vsession= Pntfr::Notifier.to(session).msg(Fxtr::Android.simple_msg)
        rs= vsession.notify
        assert rs.success? and rs.msg_sent?

        notifs= Pntfr.deliveries[@push_id]
        refute_nil notifs, "A notification should have been delivered for #{@push_id}"
        notif= notifs.last
        assert_equal 'Some Title', notif[:data][:title]
        assert_equal 'A description', notif[:data][:description]
        assert_equal 'bell', notif[:data][:sound]
      end
      def test_sound_attribute_shoud_be_sent_to_gcm
        session= DeviceSession.new(Pntfr::Platforms::ANDROID, @push_id)

        vsession= Pntfr::Notifier.to(session).msg(Fxtr::Android.simple_msg)
        rs= vsession.notify
        assert rs.success? and rs.msg_sent?

        notifs= Pntfr.deliveries[@push_id]
        refute_nil notifs, "A notification should have been delivered for #{@push_id}"
        notif= notifs.last
        assert_equal 'Some Title', notif[:data][:title]
        assert_equal 'A description', notif[:data][:description]
        assert_equal 'bell', notif[:data][:sound]
      end

      def test_sending_custom_content_for_android_should_be_added_as_more_keys
        session= DeviceSession.new(Pntfr::Platforms::ANDROID, @push_id)

        vsession= Pntfr::Notifier.to(session)
        vsession.msg(Fxtr::Common.simple_msg, Fxtr::Common.custom_msg_content)
        rs= vsession.notify
        assert rs.success? and rs.msg_sent?

        notifs= Pntfr.deliveries[@push_id]
        refute_nil notifs, "A notification should have been delivered for #{@push_id}"
        notif= notifs.last
        data= notif[:data]
        assert_equal 'Test Title', data[:title]
        assert_equal 'extra one', data[:custom][:extra1]
        assert_equal 'extra 2', data[:custom][:extra_2]
        assert_equal({lastkey: 'last value'}, data[:custom][:'last-extra'])

      end

    end
  end
end
