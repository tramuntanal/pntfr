require 'pntfr/device'
module Pntfr
  class IosTest < Minitest::Test
    def setup
      @push_id= 'IOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSios'
    end

    def test_received_content_shoud_be_ready_to_be_sent_to_apns
      device= Device.new(Pntfr::Platforms::IOS, @push_id)

      notifier= Pntfr::Notifier.to(device)
      notifier.msg({:title => 'thatitle', :description => 'thadescription', :sound => 'click.aiff', :badge => 33})
      notifier.notify
      check_ios_msg_sent(notifier)

      ios_notifs= Pntfr.deliveries[@push_id]
      refute_nil ios_notifs, "A notification should have been delivered for #{@push_id}"
      ios_notif= ios_notifs.last
      assert_equal "thatitle\nthadescription", ios_notif[:alert]
      assert_equal 'click.aiff', ios_notif[:sound]
      assert_equal 33, ios_notif[:badge]
    end

    def test_ios_information_from_previous_msg_should_be_reset_when_sending_a_new_msg
      device= IosDevice.new(Pntfr::Platforms::IOS, name, 3)
      notifier= Pntfr::Notifier.to(device)

      notifier.msg(title: 't1', description: 'd1', sound: 's1').notify
      check_ios_msg_sent(notifier)
      notifier.msg(title: 't2', description: 'd2').notify
      check_ios_msg_sent(notifier, 2)

      notifs= Pntfr.deliveries[device.push_id]
      assert_equal 5, device.num_notifs
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

    def test_sending_custom_content_for_ios_should_be_added_as_custom_keys
      device= Device.new(Pntfr::Platforms::IOS, @push_id)

      notifier= Pntfr::Notifier.to(device)
      notifier.msg(Fxtr::Common.simple_msg, Fxtr::Common.custom_msg_content)
      notifier.notify
      check_ios_msg_sent(notifier)

      ios_notifs= Pntfr.deliveries[@push_id]
      refute_nil ios_notifs, "A notification should have been delivered for #{@push_id}"
      ios_notif= ios_notifs.last
      assert_equal 'Test Title', ios_notif[:alert]
      custom= ios_notif[:other][:custom]
      assert_equal 'extra one', custom[:'extra1']
      assert_equal 'extra 2', custom[:'extra_2']
      assert_equal({lastkey: 'last value'}, custom[:'last-extra'])
    end

    def test_when_overriding_ios_credentials_should_use_new_ones
      apns_config= {
        host: 'test-host',
        pem: 'test-pem',
        port: 'test-port',
        pass: 'test-password',
      }
      ios_session= Pntfr::Session::Ios.new(apns_config)
      apns= ios_session.apns
      assert_equal 'test-host', apns.host
      assert_equal 'test-pem', apns.pem
      assert_equal 'test-port', apns.port
      assert_equal 'test-password', apns.pass
    end

    #-----------------------------------------------------------
    private
    #-----------------------------------------------------------
    def check_ios_msg_sent(notifier, num_responses=1)
      assert notifier.andr_responses.empty?
      ios_rs= notifier.ios_responses
      assert_equal num_responses, ios_rs.size
      rs= ios_rs.first
      assert rs.success? and rs.msg_sent?
    end
  end
end