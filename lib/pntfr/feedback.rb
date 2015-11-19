require File.dirname(__FILE__) + '/base_service'
require 'apns'
require 'pntfr/apns_configurator'

module Pntfr
  class Feedback < BaseService
    include Pntfr::ApnsConfigurator

    def initialize credentials=nil
      super
      configure_apns(credentials[:ios])
    end

    def bad_devices
      feedback= ::APNS.feedback
      feedback.collect do |rs|
        bd= BadDevice.new(rs.last)
        bd.timestamp= rs.first
        bd
      end
    end

  end

  class BadDevice
    attr_accessor :timestamp
    attr_accessor :push_id
    def initialize(push_id)
      @push_id= push_id
    end
  end
end
