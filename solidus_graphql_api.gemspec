# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)
require 'solidus_graphql_api/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_graphql_api'
  s.version     = SolidusGraphqlApi::VERSION
  s.summary     = 'Solidus GraphQL API'
  s.description = 'GraphQL comes to Solidus'
  s.license     = 'BSD-3-Clause'

  s.author    = 'Christian Rimondi, Alessio Rocco'
  s.email     = ['christianrimondi@nabulab.it', 'alessiorocco@nebulab.it']

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  s.add_dependency 'solidus_core', '>= 2.7'

  s.add_development_dependency 'byebug', '~> 11.0.1'
  s.add_development_dependency 'database_cleaner', '~> 1.7.0'
  s.add_development_dependency 'factory_bot', '~> 5.0.2'
  s.add_development_dependency 'rspec-rails', '~> 3.8.2'
  s.add_development_dependency 'rubocop', '~> 0.72.0'
  s.add_development_dependency 'rubocop-rspec', '~> 1.33.0'
  s.add_development_dependency 'simplecov', '~> 0.16.1'
  s.add_development_dependency 'sqlite3', '~> 1.4.1'
end
