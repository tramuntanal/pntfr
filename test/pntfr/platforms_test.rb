module Pntfr
  class PlatformsTest < Minitest::Test
    #
    # ANDROID
    #
    def test_android_shoud_be_android
      assert_equal 'ANDROID', Platforms::ANDROID
    end
    def test_checking_for_android_should_accept_all_lettercases
      assert Platforms.android? 'ANDROID'
      assert Platforms.android? 'android'
      assert Platforms.android? 'AnDrOiD'
      assert Platforms.android? 'aNdRoId'
    end
    def test_checking_for_wrong_android_platfoms_should_not_check
      refute Platforms.android? nil
      refute Platforms.android? ''
      refute Platforms.android? 'ANDROI'
      refute Platforms.android? 'ios'
      refute Platforms.android? 'NDROID'
      refute Platforms.android? 'qwertyu'
    end
    #
    # IOS
    #
    def test_ios_shoud_be_ios
      assert_equal 'IOS', Platforms::IOS
    end
    def test_checking_for_ios_should_accept_all_lettercases
      assert Platforms.ios? 'IOS'
      assert Platforms.ios? 'ios'
      assert Platforms.ios? 'iOs'
      assert Platforms.ios? 'IoS'
    end
    def test_checking_for_wrong_ios_platfoms_should_not_check
      refute Platforms.ios? nil
      refute Platforms.ios? ''
      refute Platforms.ios? 'ANDROID'
      refute Platforms.ios? 'is'
      refute Platforms.ios? 'iso'
      refute Platforms.ios? 'qwe'
    end
  end
end
