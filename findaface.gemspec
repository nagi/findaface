# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'findaface/version'

Gem::Specification.new do |spec|
  spec.name          = "findaface"
  spec.version       = Findaface::VERSION
  spec.authors       = ["Andrew Nagi"]
  spec.email         = ["andrew.nagi@gmail.com"]
  spec.summary       = %q{Finds a face in an image.}
  spec.description   = %q{This gem attempts to discern whether an image contains a clear picture of a single face. Depends on OpenCV.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby-opencv", "0.0.13"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency "pry-debugger"
  spec.add_development_dependency "awesome_print"
end
