require File.dirname(__FILE__) + '/base_service'
require File.dirname(__FILE__) + '/session/base'
require File.dirname(__FILE__) + '/notification'

module Pntfr

  class Notifier < BaseService
    def self.to devices, credentials=nil
      notif= Notifier.new(credentials)
      notif.update_devices(devices)
      notif
    end

    attr_reader :andr_responses
    attr_reader :ios_responses

    #
    # +credentials+ is a hash with 2 keys :andr and :ios, each one with its
    # given credentials:
    # - :andr => a string with the notification_key
    # - :ios  => a hash of the form {
    #    host: 'test-host',
    #    pem: 'test-pem',
    #    port: 'test-port',
    #    pass: 'test-password',
    #  }
    #
    def initialize credentials=nil
      super

      @andr_responses=[]
      @ios_responses= []
    end

    def update_devices(devices)
      devices= [devices] unless devices.kind_of?(Array)

      # the list of ANDROID push_id to send the notification to
      @andr_ids= []
      @ios_devices= []
      devices.each do |device|
        if Platforms.android? device.platform
          @andr_ids << device.push_id
        elsif Platforms.ios? device.platform
          @ios_devices << device
        end
      end
      self
    end

    def msg content, custom=nil
      @msg= Notification.new(content, custom)
      self
    end

    def notify
      if any_android_device?
        @andr_responses << andr_session.notify(@andr_ids, @msg.to_android)
      end
      if any_ios_device?
        @ios_responses << ios_session.notify(@ios_devices, @msg.to_ios)
      end
    end

    def any_android_device?
      @andr_ids.any?
    end

    def any_ios_device?
      @ios_devices.any?
    end

    #--------------------------------------------
    private
    #--------------------------------------------
    def andr_session
      @andr_session||= Pntfr::Session::Android.new(@credentials[:andr])
    end
    def ios_session
      @ios_session||= Pntfr::Session::Ios.new(@credentials[:ios])
    end

  end

end
