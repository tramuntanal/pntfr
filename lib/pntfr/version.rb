#
# Let's follow Semantic Versioning: http://semver.org/
#
module Pntfr
  #
  # PATCH v0.5.3
  # - [FIX] Depend on apns2 gem to be connection failure tolerant during big batches.
  #
  # PATCH v0.5.2
  # - Fix. [FIX] Increase badge independently for each device.
  #
  # PATCH v0.5.1
  # - Use increment! instead of increment when incrementing badge on a device object
  # that quacks like ActiveRecord.
  #
  # MINOR v0.5.0
  # - Badge control now can use ActiveRecord's increment method.
  #
  # PATCH v0.4.1
  # - Republish gem after gem yanking it.
  #
  # MINOR v0.4.0
  # - [FEATURE] When overriding ios credentials, merge over general configuration.
  #
  # MINOR v0.3.0
  # - Performance improvement: Allow sending one message to many devices in one
  # single call (on both platforms).
  # - Allow overriding general configuration credentials when instantiating each
  # Notifier (on both platforms).
  # - Internal refactoring.
  VERSION = '0.5.3'
end
