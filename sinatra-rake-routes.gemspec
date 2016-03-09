# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sinatra-rake-routes/version"

Gem::Specification.new do |gem|
  gem.name = %q{sinatra-rake-routes}
  gem.version = SinatraRakeRoutes::VERSION
  gem.author = "Peter Graham"
  gem.summary = %q{`rake routes` command for Sinatra applications}
  gem.email = %q{peter@wealthsimple.com}
  gem.description   = %q{}
  gem.summary       = %q{}
  gem.homepage      = %q{}
  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rake"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-collection_matchers"
  gem.add_development_dependency "rspec-its"
end
