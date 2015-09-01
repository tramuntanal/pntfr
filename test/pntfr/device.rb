# Pntfr's expected models to be used for testing purposes

# minimal expected device
Pntfr::Device= Struct.new(:platform, :push_id)
# device with num_notifs which will be autoincremented on each sent msg
Pntfr::IosDevice= Struct.new(:platform, :push_id, :num_notifs)
