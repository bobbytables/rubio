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

  gem.add_runtime_dependency('hashie') # Hash method access
  gem.add_runtime_dependency('httparty') # Used to tell Rdio to let us in
  gem.add_runtime_dependency('activesupport', '~> 3.2') # Hash method access

  gem.add_development_dependency('rspec') # Because who likes TestUnit really?
  gem.add_development_dependency('awesome_print') # Pretty debugging
end
