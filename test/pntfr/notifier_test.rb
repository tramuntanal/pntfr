require 'pntfr/device'
module Pntfr
  class NotifierTest < Minitest::Test

    def setup
      @andr_dev= Device.new(Pntfr::Platforms::ANDROID, 'ANDR_ID')
      @ios_dev= Device.new(Pntfr::Platforms::IOS, 'IOS_ID')
    end
    def test_android_device_should_instantiate_notifier
      notifier= Pntfr::Notifier.to(@andr_dev)
      refute_nil notifier
      assert notifier.any_android_device?
    end
    def test_ios_device_should_instantiate_notifier
      notifier= Pntfr::Notifier.to(@ios_dev)
      refute_nil notifier
      assert notifier.any_ios_device?
    end

    def test_creating_notifier_with_many_devices_should_create_a_notifier
      devices= [@andr_dev, @ios_dev]
      notifier= Pntfr::Notifier.to(devices)
      refute_nil notifier
      assert notifier.any_android_device?
      assert notifier.any_ios_device?
    end

    def test_when_updating_only_andr_devices_older_devices_from_ios_platforms_should_be_reseted
      notifier= Pntfr::Notifier.to([@andr_dev, @ios_dev])
      assert notifier.any_android_device?
      assert notifier.any_ios_device?

      notifier.update_devices(@andr_dev)
      assert notifier.any_android_device?
      refute notifier.any_ios_device?
    end

    def test_when_updating_only_ios_devices_older_devices_from_andr_platforms_should_be_reseted
      notifier= Pntfr::Notifier.to([@andr_dev, @ios_dev])
      assert notifier.any_android_device?
      assert notifier.any_ios_device?

      notifier.update_devices(@ios_dev)
      refute notifier.any_android_device?
      assert notifier.any_ios_device?
    end

    def test_setting_string_credentials_should_raise_argument_error
      begin
        Pntfr::Notifier.to(@andr_dev, 'ios=andr')
        raise 'Should have raised an ArgumentError'
      rescue ArgumentError
      end
    end

    def test_setting_empty_hash_credentials_should_raise_argument_error
      begin
        Pntfr::Notifier.to(@andr_dev, {})
        raise 'Should have raised an ArgumentError'
      rescue ArgumentError
      end
    end

    def test_setting_wrong_credentials_should_raise_argument_error
      begin
        Pntfr::Notifier.to(@ios_dev, {key1: 'asdf', wrongK: {}, android: [], iphone: ''})
        raise 'Should have raised an ArgumentError'
      rescue ArgumentError
      end
    end

  end
end