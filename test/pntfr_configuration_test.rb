module Pntfr
  class ConfigTest < Minitest::Test
    def test_ios_params_should_have_been_taken
      Pntfr.configure do |config|
        config.apns= {
          host: 'test-host',
          pem: 'test-pem',
          port: 'test-port',
          pass: 'test-password',
        }
      end
      apns= Pntfr.config.apns
      assert_equal 'test-host', apns[:host]
      assert_equal 'test-pem', apns[:pem]
      assert_equal 'test-port', apns[:port]
      assert_equal 'test-password', apns[:pass]
    end

    def test_android_params_should_have_been_taken
      Pntfr.configure do |config|
        config.gcm= {:notification_key => 'SOME-TEST-KEY'}
      end
      gcm= Pntfr.config.gcm
      assert_equal 'SOME-TEST-KEY', gcm[:notification_key]
    end

  end
end