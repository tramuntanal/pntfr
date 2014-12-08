require 'minitest/autorun'
require 'pntfr'

ENV['ENV']= 'test'

# require all test files
def add_to_path(d)
  Dir.entries(d).each do |f|
    next if f == '.' or f == '..'
    file= File.join(d, f)
    if File.directory?(file)
      add_to_path(file)
    elsif f.end_with?('test.rb')
      require(file)
    end
  end
end
add_to_path(File.dirname(__FILE__))

#
# Extend library to enable testing.
#
module Pntfr
  @@deliveries= {}
  def self.deliveries
    @@deliveries
  end
  def self.add_delivery push_id, n
    if @@deliveries.has_key?(push_id)
      @@deliveries[push_id] << n
    else
      @@deliveries[push_id]= [n]
    end
  end
end
