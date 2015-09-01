# Encapsulates the content of a notification in a neutral maneer.
# For each platform it can return the notification in the corresponding format
# using #to_platform like methods (i.e. #to_ios)
#

module Pntfr
  class Notification
    FILE_EXTENSION_REGEXP= /(\.[^\.]+)\z/

    def initialize content, custom=nil
      @content= content
      @custom= custom
    end

    def to_ios
      alert= @content[:title]
      alert+= "\n#{@content[:description]}" if @content.key?(:description)
      sound= @content[:sound]
      badge= @content[:badge]
      badge= @content[:badge].to_i if badge
      n= {:alert => alert, :sound => 'default'}
      n[:sound]= sound if sound
      n[:badge]= badge if badge
      n.merge!({other: {custom: @custom}}) if @custom
      n
    end

    def to_android
      data= {
        :title        => @content[:title],
        :description  => @content[:description],
      }
      data[:sound]= remove_extension(@content[:sound]) unless @content[:sound].nil?
      data[:custom]= @custom if @custom
      data
    end
    def remove_extension filename
      filename.gsub(FILE_EXTENSION_REGEXP, '')
    end

  end
end
