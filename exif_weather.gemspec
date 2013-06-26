# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exif_weather/version'

Gem::Specification.new do |spec|
  spec.name          = "exif_weather"
  spec.version       = ExifWeather::VERSION
  spec.authors       = ["Toshiyuki Suzumura"]
  spec.email         = ["suz.labo@amail.plala.or.jp"]
  spec.description   = %q{Get weather information based on GPS information of JPEG.}
  spec.summary       = %q{Get weather information via http://openweathermap.org/ based on GPS information of JPEG.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "exifr"
  spec.add_development_dependency "json"
end
