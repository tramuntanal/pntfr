#
# Extend library to enable testing.
#
if Pntfr.test_env?
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
end