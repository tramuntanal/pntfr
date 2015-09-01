require 'pntfr/device'
require 'fxtr'

module Pntfr
  class AndroidTest < Minitest::Test

    def setup
      @push_id= 'ANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROID'
    end
    def test_received_content_shoud_be_sent_to_gcm
      device= Device.new(Pntfr::Platforms::ANDROID, @push_id)

      notifier= Pntfr::Notifier.to(device).msg(Fxtr::Android.simple_msg)
      notifier.notify
      check_andr_msg_sent(notifier)

      notifs= Pntfr.deliveries[@push_id]
      refute_nil notifs, "A notification should have been delivered for #{@push_id}"
      notif= notifs.last
      assert_equal 'Some Title', notif[:data][:title]
      assert_equal 'A description', notif[:data][:description]
      assert_equal 'bell', notif[:data][:sound]
    end
    def test_sound_attribute_shoud_be_sent_to_gcm
      device= Device.new(Pntfr::Platforms::ANDROID, @push_id)

      notifier= Pntfr::Notifier.to(device).msg(Fxtr::Android.simple_msg)
      notifier.notify
      check_andr_msg_sent(notifier)

      notifs= Pntfr.deliveries[@push_id]
      refute_nil notifs, "A notification should have been delivered for #{@push_id}"
      notif= notifs.last
      assert_equal 'Some Title', notif[:data][:title]
      assert_equal 'A description', notif[:data][:description]
      assert_equal 'bell', notif[:data][:sound]
    end

    def test_sending_custom_content_for_android_should_be_added_as_more_keys
      device= Device.new(Pntfr::Platforms::ANDROID, @push_id)

      notifier= Pntfr::Notifier.to(device)
      notifier.msg(Fxtr::Common.simple_msg, Fxtr::Common.custom_msg_content)
      notifier.notify
      check_andr_msg_sent(notifier)

      notifs= Pntfr.deliveries[@push_id]
      refute_nil notifs, "A notification should have been delivered for #{@push_id}"
      notif= notifs.last
      data= notif[:data]
      assert_equal 'Test Title', data[:title]
      assert_equal 'extra one', data[:custom][:extra1]
      assert_equal 'extra 2', data[:custom][:extra_2]
      assert_equal({lastkey: 'last value'}, data[:custom][:'last-extra'])

    end

    def test_when_overriding_android_credentials_should_use_new_ones
      notification_key= 'OVERRIDEN-TEST-KEY'
      andr_session= Pntfr::Session::Android.new(notification_key)
      assert_equal 'OVERRIDEN-TEST-KEY', andr_session.gcm.api_key
    end

    #-------------------------------------------------------
    private
    #-------------------------------------------------------
    def check_andr_msg_sent(notifier)
      assert notifier.ios_responses.empty?
      andr_rs= notifier.andr_responses
      assert_equal 1, andr_rs.size
      rs= andr_rs.first
      assert rs.success? and rs.msg_sent?
    end

  end
end