# Pntfr
Push Notifier is a simple adapter for APNS (Apple Push Notification Service) and GCM (Google Cloud Messaging) gems, that way you can use same API to send push notifications to both devices.

# Usage
## Installation
Add it to your Gemfile:

gem 'pntfr', '~>0.1.1'

## Configuration
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
Pntfr suposes you have session objects with the `platform` and `push_id` attributes.
Also, and optionally, a `num_notifs` integer attribute will be automagically managed to 
monitor Apple's badge in notifications.

The neutral model for the content of the messages is composed by a title and a description,
this maps directly to Android notification's `data` content wile is concatenated with a newline
for Apns notificaitons.

Sending a notification is quite simple.
- First, create a virtual session to manage each recipient's connection. This virtual
session is platform specific and will take care of the message structure for the
given platform and of connecting through the correct driver.
- Second, set the message to be sent
- Third, notify.
Your're done.

Given you have a DeviceSession model in your application. Then to send notifications to a device do:
```ruby
# get device session
session= DeviceSession.new(platform: Pntfr::Platforms::IOS, push_id: '...')
# send notification to the given device
Pntfr::Notifier.to(session).msg({:title => 'Some Title', :description => 'A description'}).notify

#send many notifications to a given device
vsession= Pntfr::Notifier.to(session)
vsession.msg({:title => 'Some Title', :description => 'A description'}).notify
vsession.msg({
  :title => 'Some Other Title',
  :description => 'Another description',
  :sound => 'flipping-sound.aiff'})
vsession.notify

# send notifications with custom content (an extra optional parameter to #msg)
vsession= Pntfr::Notifier.to(session)
vsession.msg(
  {:title => 'Short Title'},
  {
    :extra1 => 'extra one',
    :extra_2 => 'extra 2',
    :'last-extra' => {lastkey: 'last value'}
  }
)
vsession.notify

# Custom content will be found into :custom key for Android.
# For iOS each custom key is transformed into an 'acme-' prefixed key.
```
# Testing
For testing one can check the messages to be sent to each given driver the same way
that Rails ActiveMailer works: messages are stacked into `Pntfr.deliveries[push_id]`,
where for each key (push_id is the identifier of the device) one will get an ordered array 
with all messages sent to the device while testing. Of course, while testing,
notifications are not sent, only stored in the stack.

# Resources
- Depends on APNS gem: https://rubygems.org/gems/apns
- Depends on GCM gem: https://rubygems.org/gems/gcm
- Alternative, that supports more platforms but without a unified api: https://github.com/rpush/rpush

# Authors

- Oliver HV <https://github.com/tramuntanal>

Contributions are always welcome and greatly appreciated!
