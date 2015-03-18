# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'check_url/version'

Gem::Specification.new do |spec|
  spec.name          = "check_url"
  spec.version       = CheckUrl::VERSION
  spec.authors       = ["Kumar"]
  spec.email         = ["asharma.ror@gmail.com"]
  spec.summary       = %q{URL Validation}
  spec.description   = %q{Ruby Library for validating urls in Rails and Javascript in front end}
  spec.homepage      = "https://github.com/asharma-ror"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
  
  spec.add_dependency "addressable"
  spec.add_dependency "activesupport"
  spec.add_dependency "activerecord"
  spec.add_dependency "httpi"


end
