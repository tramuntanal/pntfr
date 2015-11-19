module Pntfr
  class BaseService
    def initialize credentials
      validate_credentials(credentials)
      @credentials= credentials || {}
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
    def validate_credentials(credentials)
      return if credentials.nil?
      if !credentials.is_a?(Hash)
        raise ArgumentError.new('Credentials should be a Hash with either :andr or :ios keys!')
      end
      if !(credentials.has_key?(:andr) or credentials.has_key?(:ios))
        raise ArgumentError.new('Either :andr or :ios service credentials should have been provided!')
      end
    end

  end
end
