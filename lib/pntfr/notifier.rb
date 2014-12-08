require File.dirname(__FILE__) + '/virtual_session/base'

module Pntfr

  class Notifier
    def self.to session
      if Platforms.android? session.platform
        Pntfr::VirtualSession::Android.new(session)
      elsif Platforms.ios? session.platform
        Pntfr::VirtualSession::Ios.new(session)
      end
    end
  end

end
