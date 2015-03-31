# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chronos/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "chronos-api"
  gem.version       = Chronos::VERSION
  gem.authors       = ["Algolia Team"]
  gem.email         = %w{support@algolia.com}
  gem.description   = %q{A simple REST client for the Chronos API}
  gem.summary       = %q{A simple REST client for the Chronos API}
  gem.homepage      = 'https://github.com/algolia/chronos-api'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w{lib}

  gem.add_dependency 'json'
  gem.add_dependency 'httparty', '~> 0.11.0'
  gem.add_dependency 'trollop', '~> 2.0.0'
  gem.add_dependency 'terminal-table', '~> 1.4.3'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rspec-its'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'pry'
end
