module Pntfr
  # For IOS do not prefix custom fields with 'acme-' in the notification,
  # instead group them all into a :custom key, like in Android.
  #
  # As this change doesn't break the gems API but changes device's management of
  # received notifications, lets change only the minor version. This will also
  # reflect the adding of the custom keys feature.
  VERSION = '0.2.0'
end
