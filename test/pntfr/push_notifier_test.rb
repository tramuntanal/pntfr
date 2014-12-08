module Pntfr
  class NotifierTest < Minitest::Test
    def initialize method_name
      super
      Pntfr.configure {}
    end
    def setup
      @PushSessionClass= Struct.new(:platform, :push_id)
    end

    #
    # COMMON
    #
    def test_android_sessions_should_instantiate_android_virtual_sessions
      session= @PushSessionClass.new(Pntfr::Platforms::ANDROID)
      vsess= Pntfr::Notifier.to(session)
      assert vsess.is_a?(Pntfr::VirtualSession::Android)
    end
    def test_ios_sessions_should_instantiate_ios_virtual_sessions
      session= @PushSessionClass.new(Pntfr::Platforms::IOS)
      vsess= Pntfr::Notifier.to(session)
      assert vsess.is_a?(Pntfr::VirtualSession::Ios)
    end

    #
    # ANDROID
    #
    def test_received_content_shoud_be_sent_to_gcm
      push_id= 'ANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROIDANDROID'
      session= @PushSessionClass.new(Pntfr::Platforms::ANDROID, push_id)

      Pntfr::Notifier.to(session).msg({:title => 'Some Title', :description => 'A description'}).notify

      notifs= Pntfr.deliveries[push_id]
      refute_nil notifs, "A notification should have been delivered for #{push_id}"
      notif= notifs.last
      assert_equal "Some Title", notif[:data][:title]
      assert_equal "A description", notif[:data][:description]
    end

    #
    # IOS
    #
    def test_received_content_shoud_be_ready_to_be_sent_to_apns
      push_id= 'IOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSiosIOSios'
      session= @PushSessionClass.new(Pntfr::Platforms::IOS, push_id)

      Pntfr::Notifier.to(session).msg({:title => 'thatitle', :description => 'thadescription', :sound => 'click.aiff', :badge => 33}).notify

      ios_notifs= Pntfr.deliveries[push_id]
      refute_nil ios_notifs, "A notification should have been delivered for #{push_id}"
      ios_notif= ios_notifs.last
      assert_equal "thatitle\nthadescription", ios_notif[:alert]
      assert_equal 'click.aiff', ios_notif[:sound]
      assert_equal 33, ios_notif[:badge]
    end

  end
end