require 'pntfr/device'

module Pntfr
  class IosBadgeTest < Minitest::Test
    def test_sending_a_notification_increments_notifier_notifications_num_on_non_active_record_devices
      device= Pntfr::IosDevice.new(Pntfr::Platforms::IOS, '1id2id3id4id5id', 0)

      Pntfr::Notifier.to(device).msg({:title => 't', :description => 'd'}).notify

      check_badge(1, '1id2id3id4id5id')
      assert_equal 1, device.num_notifs
    end
    def test_sending_a_notification_increments_notifier_notifications_num_on_active_record_devices
      device= Pntfr::ArIosDevice.new(Pntfr::Platforms::IOS, '1ar2ar3ar4ar5ar', 0)

      Pntfr::Notifier.to(device).msg({:title => 't', :description => 'd'}).notify

      check_badge(1, '1ar2ar3ar4ar5ar')
      assert_equal 1, device.num_notifs
    end
    def test_sending_a_notification_to_devices_with_different_badge_should_send_different_badge_for_each_device
      devices= [Pntfr::ArIosDevice.new(Pntfr::Platforms::IOS, '1badge', 1),
        Pntfr::ArIosDevice.new(Pntfr::Platforms::IOS, '2badge', 2)]

      Pntfr::Notifier.to(devices).msg({:title => 'MultiBadge', :description => 'Test'}).notify

      check_badge(2, '1badge')
      check_badge(3, '2badge')
    end
    ###################################################
    private
    ###################################################
    def check_badge(expected_badge, push_id)
      notifs= Pntfr.deliveries[push_id]
      notif= notifs.last
      assert_equal expected_badge, notif[:badge], "Nofication for device [#{push_id}] should have expected badge"
    end
  end
end