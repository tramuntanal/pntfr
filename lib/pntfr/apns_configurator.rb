module Pntfr
  module ApnsConfigurator
    def configure_apns config_override
      config= Pntfr.config.apns
      unless config_override.nil?
        config= config.clone.merge(config_override)
      end
      APNS.host = config[:host]
      APNS.pem  = config[:pem]
      APNS.port = config[:port]
      APNS.pass = config[:pass]
      @apns= APNS
    end
  end
end
