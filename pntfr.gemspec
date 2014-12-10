# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pntfr/version'

Gem::Specification.new do |spec|
  spec.name          = 'pntfr'
  spec.version       = Pntfr::VERSION
  spec.authors       = ['oliver']
  spec.email         = ['oliver.hv@coditramuntana.com']
  spec.summary       = %q{Push notifier is a simple adapter for APNS and GCM gems, that way you can use same api to send push notifications to both devices.}
  #  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://www.coditramuntana.com"
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
