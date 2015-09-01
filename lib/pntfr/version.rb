module Pntfr
  #
  # - Performance improvement: Allow sending one message to many devices in one
  # single call (on both platforms).
  # - Allow overriding general configuration credentials when instantiating each
  # Notifier (on both platforms).
  # - Internal refactoring.
  #
  # As this change don't break the gem's API (it extends it), lets change only
  # minor version.
  VERSION = '0.3.0'
end
