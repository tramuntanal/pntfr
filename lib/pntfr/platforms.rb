module Pntfr
  module Platforms
    ANDROID= 'ANDROID'
    IOS=     'IOS'
    def self.android? string
      return false if string.nil? or string.empty?
      ANDROID == string.upcase
    end
    def self.ios? string
      return false if string.nil? or string.empty?
      IOS == string.upcase
    end
    # All supported platforms
    def self.all
      [ANDROID, IOS]
    end
    # Returns a list of platforms:
    # - if the +platform+ param is present wraps it into an Array.
    # - else returns all supported platforms.
    #
    def self.given_or_default_to_all(platform)
      if platform
        [platform]
      else
        Pntfr::Platforms.all
      end
    end
  end
end
