# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoatree/version'

Gem::Specification.new do |spec|
  spec.name          = "cocoatree"
  spec.version       = Cocoatree::VERSION
  spec.authors       = ["Jens Bissinger"]
  spec.email         = ["mail@jens-bissinger.de"]
  spec.description   = %q{Cocoapods Index}
  spec.summary       = %q{Cocoapods Index}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-rake"
  spec.add_development_dependency "guard-sass"

  spec.add_dependency "cocoapods-core"
  spec.add_dependency "octokit"
  spec.add_dependency "slim"
  spec.add_dependency "hashie"
  spec.add_dependency "sass"
  spec.add_dependency "actionpack"
  spec.add_dependency "activesupport"
end
