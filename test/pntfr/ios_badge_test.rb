require 'pntfr/device'

module Pntfr
  class IosBadgeTest < Minitest::Test
    def test_sending_a_notification_increments_notifier_notifications_num
      device= Pntfr::IosDevice.new(Pntfr::Platforms::IOS, '1id2id3id4id5id', 0)

      Pntfr::Notifier.to(device).msg({:title => 't', :description => 'd'}).notify

      notifs= Pntfr.deliveries['1id2id3id4id5id']
      notif= notifs.last
      assert_equal 1, notif[:badge]
      assert_equal 1, device.num_notifs
    end
  end
end