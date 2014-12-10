require 'minitest/autorun'

ENV['ENV']= 'test'

require 'pntfr'

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

