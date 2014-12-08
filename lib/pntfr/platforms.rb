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
  end
end
