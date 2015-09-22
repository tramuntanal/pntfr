# Pntfr's expected models to be used for testing purposes

# minimal expected device
Pntfr::Device= Struct.new(:platform, :push_id)
# device with num_notifs which will be autoincremented on each sent msg
Pntfr::IosDevice= Struct.new(:platform, :push_id, :num_notifs)
# A device class that quacks like ActiveRecord with num_notifs which will be autoincremented on each sent msg
class Pntfr::ArIosDevice < Pntfr::IosDevice
  def increment!(attr_name, by=1)
    self.send("#{attr_name}=", by)
  end
end
