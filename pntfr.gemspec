# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pntfr/version'

Gem::Specification.new do |spec|
  spec.name          = 'pntfr'
  spec.version       = Pntfr::VERSION
  spec.authors       = ['oliver']
  spec.email         = ['oliver.hv@coditramuntana.com']
  spec.summary       = %q{Push Notifier is a simple adapter for APNS (Apple Push Notification Service) and GCM (Google Cloud Messaging) gems, that way you can use one message format and one library to send push notifications to both devices.}
  spec.description   = %q{One single API to send push notifications to Android and iOS devices.}
  spec.homepage      = 'https://github.com/tramuntanal/pntfr'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'apns', '~> 1.0', '>= 1.0.0'
  spec.add_runtime_dependency 'gcm', '~> 0.0', '>= 0.0.9'
  spec.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.1'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
