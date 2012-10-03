# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acouchi/version'

Gem::Specification.new do |gem|
  gem.name          = "acouchi"
  gem.version       = Acouchi::VERSION
  gem.authors       = ["Andrew Vos"]
  gem.email         = ["andrew.vos@gmail.com"]
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/AndrewVos/acouchi"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency "httparty"
  gem.add_runtime_dependency "childprocess"
end
