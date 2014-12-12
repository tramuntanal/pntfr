# Pntfr's expected models to be used for testing purposes

# minimal expected session
Pntfr::DeviceSession= Struct.new(:platform, :push_id)
# session with num_notifs which will be autoincremented on each sent msg
Pntfr::IosDeviceSession= Struct.new(:platform, :push_id, :num_notifs)
