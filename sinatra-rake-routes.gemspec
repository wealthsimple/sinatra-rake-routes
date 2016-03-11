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
  gem.description   = %q{Rake command for printing out all defined routes in Sinatra applications}
  gem.homepage      = %q{https://github.com/wealthsimple/sinatra-rake-routes}
  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.licenses      = ["MIT"]

  gem.required_ruby_version = ">= 1.9.3"
  gem.add_dependency "rake", ">= 0"

  gem.add_development_dependency "rspec", "~> 3.4"
  gem.add_development_dependency "sinatra", "~> 1.4"
  gem.add_development_dependency "rspec_junit_formatter", "~> 0.2"
end
