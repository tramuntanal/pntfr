# Fixtures
#
#

module Fxtr
  module Android
    def self.simple_msg
      {
        :title => 'Some Title', :description => 'A description',
        :sound => 'bell.caff'
      }
    end
  end
  module Common
    # without description, only title
    def self.simple_msg
      {:title => 'Test Title'}
    end
    def self.custom_msg_content
      {
        :extra1 => 'extra one',
        :extra_2 => 'extra 2',
        :'last-extra' => {lastkey: 'last value'}
      }
    end
  end
end
