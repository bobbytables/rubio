# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rubio/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Robert Ross"]
  gem.email         = ["robert@maintainedauto.com"]
  gem.description   = %q{A DSL to interact with the Rdio API}
  gem.summary       = %q{A simple gem to interact with the Rdio API}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rubio"
  gem.require_paths = ["lib"]
  gem.version       = Rubio::VERSION
end
