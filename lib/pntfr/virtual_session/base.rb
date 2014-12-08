module Pntfr
  module VirtualSession
    class Base
      def initialize session
        @session= session
        @push_id= @session.push_id
      end
      def msg content
        raise 'not implemented!'
      end
    end
  end
end
require File.dirname(__FILE__) + '/android'
require File.dirname(__FILE__) + '/ios'