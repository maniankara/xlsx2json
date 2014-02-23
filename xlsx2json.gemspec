# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xlsx2json/version'

Gem::Specification.new do |spec|
  spec.name          = "xlsx2json"
  spec.version       = Xlsx2json::VERSION
  spec.authors       = ["pythonicrubyist"]
  spec.email         = ["pythonicrubyist@gmail.com"]
  spec.description   = %q{Converts Excel(xlsx and xlsm) worksheet into a JSON file.}
  spec.summary       = %q{Xlsx2json is a Ruby gem that facilitates transformation of an Excel(xlsx and xlsm) into json without loading files into database or memory.}
  spec.homepage      = "https://github.com/pythonicrubyist/xlsx2json"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.13.0'

  spec.add_dependency 'creek', '>= 1.0.4'
  spec.add_dependency 'json'
end
