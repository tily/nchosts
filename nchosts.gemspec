# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nchosts/version'

Gem::Specification.new do |spec|
  spec.name          = "nchosts"
  spec.version       = Nchosts::VERSION
  spec.authors       = ["tily"]
  spec.email         = ["tily05@gmail.com"]
  spec.summary       = %q{command to collect hosts info}
  spec.description   = %q{command to collect hosts info}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "thor"
  spec.add_dependency "ace-client"
  spec.add_dependency "ace-client-ext"
  spec.add_dependency "builder"
  spec.add_dependency "json"
  spec.add_dependency "erubis"
end
