# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave-data/version'

Gem::Specification.new do |spec|
  spec.name          = 'carrierwave-data'
  spec.version       = CarrierWave::Data::VERSION
  spec.authors       = ['Ramy Aboul Naga']
  spec.email         = ['ramy.naga@gmail.com']
  spec.summary       = %q{Allows carrierwave to process Base64 encoded file uploads.}
  spec.description   = %q{Allows carrierwave to process Base64 encoded file uploads by providing a `#{mounted_as}_data=` method that accepts Base64 encoded strings and sets the #{mounted_as} column accordingly.}
  spec.homepage      = 'https://github.com/RaMin0/carrierwave-data'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'carrierwave', '~> 0'
end
