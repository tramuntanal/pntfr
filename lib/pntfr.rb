require 'pntfr/version'
require 'pntfr/platforms'
require 'pntfr/notifier'

module Pntfr
  def self.test_env?
    ENV['ENV'] == 'test' or (defined?(Rails) and Rails.env.test?)
  end

  class << self
    attr_accessor :config
  end
  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end

  class Configuration
    attr_accessor :apns
    attr_accessor :gcm

    def initialize
      @apns= {}
      @gcm= {}
    end
  end
end

# produce empty configuration
Pntfr.configure {}

require 'pntfr/test_ext'