# Pntfr
Push Notifier is a simple adapter for APNS (Apple Push Notification Service) and GCM (Google Cloud Messaging) gems, that way you can use one message format and one library to send push notifications to both devices.

# Usage
## Installation
Add it to your Gemfile:

gem 'pntfr', '0.4.1'

## Configuration
Pntfr can be configured in two ways.
- Setting a global configuration
- Setting notification service's configuration on each call.

### Global configuration
To configure the Apple Push Notification Service just set the Hash of keys to be used:
```ruby
Pntfr.configure do |config|
  config.apns= {
    host: 'gateway.sandbox.push.apple.com',
    pem: 'config/apns/development_push.keys.pem',
    port: 2195,
    pass: 'ThaPasswah',
  }
end
```
To configure the Google Cloud Messaging
```ruby
Pntfr.configure do |config|
  config.gcm= {:notification_key => 'SomeSecretKeySomeSecretKeySomeSecretKey'}
end
```
You will normally configure both at the same time:
```ruby
Pntfr.configure do |config|
  config.apns= {
    host: 'gateway.sandbox.push.apple.com',
    pem: 'config/apns/development_push.keys.pem',
    port: 2195,
    pass: 'ThaPasswah',
  }
  config.gcm= {:notification_key => 'SomeSecretKeySomeSecretKeySomeSecretKey'}
end
```

## Sending messages
Pntfr suposes you have device objects, or other kind of model, with `platform` and `push_id` attributes.
Also, and optionally, a `num_notifs` integer attribute will be automagically managed to 
monitor Apple's badge in notifications (for device objects with an `increment` method
(like ActiveRecord;) will use `increment(:num_notifs)`, for non ActiveRecord like
device objects `num_notifs+= 1` will be used).

In order to avoid having to create a different message for each platform Pntfr
expects a "neutral format" for the messages. The neutral format of the messages
is a map composed by `title` and `description` keys.
This keys are added directly to Android notification's `data` content, on the
other side, for Apns notifications, are concatenated with a newline

Sending a notification is quite simple.
- First, create a notifier to manage each recipient's connection. This notifier
manages platform specific sessions and will take care of the message structure
for each platform and of connecting through the correct driver.
- Second, set the message to be sent
- Third, notify.
You're done.

Given you have a Device model in your application. Then to send notifications to a device do:
```ruby
# SEND ONE NOTIFICATION TO A SINGLE DEVICE
# get the device to be notified
device= Device.new(platform: Pntfr::Platforms::IOS, push_id: '...')
# send notification to the given device
Pntfr::Notifier.to(device).msg({:title => 'Some Title', :description => 'A description'}).notify

# SEND ONE NOTIFICATION TO MANY DEVICES
# using ActiveRecord for example
notifier= Pntfr::Notifier.new
notifier.notify({
  :title => 'Some Other Title',
  :description => 'Another description',
  :sound => 'flipping-sound.aiff'})
Device.find_in_batches do |devices|
  notifier.update_devices(devices)
  notifier.notify
end

# SEND MANY NOTIFICATIONS TO A GIVEN DEVICE
notifier= Pntfr::Notifier.to(device)
notifier.msg({:title => 'Title1', :description => 'Description 1'}).notify
notifier.msg({:title => 'Title2', :description => 'Description 2'}).notify
notifier.msg({:title => 'Title3', :description => 'Description 3'}).notify
...

# NOTIFICATIONS WITH CUSTOM CONTENT
# send notifications with custom content (extra and optional parameter to #msg)
notifier= Pntfr::Notifier.to(device)
notifier.msg(
  {:title => 'Short Title'},
  {
    :extra1 => 'extra one',
    :extra_2 => 'extra 2',
    :'last-extra' => {lastkey: 'last value'}
  }
)
notifier.notify
# for IOS will result in the adding the custom content in the msg this way:
msg[:other][:custom]= {
    :extra1 => 'extra one',
    :extra_2 => 'extra 2',
    :'last-extra' => {lastkey: 'last value'}
  }
# for ANDROID will result in the adding the custom content in the msg this way:
msg[:custom]= {
    :extra1 => 'extra one',
    :extra_2 => 'extra 2',
    :'last-extra' => {lastkey: 'last value'}
  }

# SETTING ANPS AND GCN CREDENTIALS ON EACH NOTIFICATION
# using different configuration on each call
credentials= {
  # for ios you select what you override, in this case host and port will be
  # kept from the general configuration
  ios: {
        pem: 'test-pem',
        pass: 'test-password',
      },
  andr: 'notification key'
}
notifier= Pntfr::Notifier.new( credentials )
# this Notifier instance overrides the global credentials configuration (if any)
notifier.update_devices(device).msg({:title => 'Title', :description => 'Description'}).notify
# of course the device's push_id and credentials should belong to the same application.
```
# Testing
For testing, one can check the messages sent to each device the same way
that Rails ActiveMailer works: messages are stacked into `Pntfr.deliveries[push_id]`,
where for each key (push_id is the identifier of the device) one will get an ordered array 
with all messages sent to the device while testing. Of course, while testing,
notifications are not sent, only stored in the stack.

# Further development (roadmap)
- Update cannonical push id when required for gcm.
- Retrieve feedback on sent messages for apns.

# Resources
- Depends on APNS gem: https://rubygems.org/gems/apns
- Depends on GCM gem: https://rubygems.org/gems/gcm
- Alternative, that supports more platforms but without a unified api: https://github.com/rpush/rpush

# Authors

- Oliver Valls <https://github.com/tramuntanal>

Contributions are always welcome and greatly appreciated!
