# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robotium-bridge/version'

Gem::Specification.new do |gem|
  gem.name          = "robotium-bridge"
  gem.version       = Robotium::Bridge::VERSION
  gem.authors       = ["Andrew Vos"]
  gem.email         = ["andrew.vos@gmail.com"]
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "httparty"
end
