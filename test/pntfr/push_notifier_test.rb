require 'pntfr/device_session'
module Pntfr
  class NotifierTest < Minitest::Test

    def test_android_sessions_should_instantiate_android_virtual_sessions
      session= DeviceSession.new(Pntfr::Platforms::ANDROID)
      vsess= Pntfr::Notifier.to(session)
      assert vsess.is_a?(Pntfr::VirtualSession::Android)
    end
    def test_ios_sessions_should_instantiate_ios_virtual_sessions
      session= DeviceSession.new(Pntfr::Platforms::IOS)
      vsess= Pntfr::Notifier.to(session)
      assert vsess.is_a?(Pntfr::VirtualSession::Ios)
    end

  end
end