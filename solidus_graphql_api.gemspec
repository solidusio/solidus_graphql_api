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

  if s.respond_to?(:metadata)
    s.metadata["homepage_uri"] = s.homepage if s.homepage
    s.metadata["source_code_uri"] = s.homepage if s.homepage
  end

  s.required_ruby_version = '~> 2.4'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.test_files = Dir['spec/**/*']
  s.bindir = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'batch-loader', '>= 1.4.1', '< 1.6.0'
  s.add_dependency 'graphql', '>= 1.10', '< 1.12'
  s.add_dependency 'solidus_core', ['>= 2.5', '< 3']
  s.add_dependency 'solidus_support', '~> 0.5'

  s.add_development_dependency 'graphql-schema_comparator', '~> 1.0.0'
  s.add_development_dependency 'pry', '~> 0.13.1'
  s.add_development_dependency 'simplecov', '~> 0.16.1'
  s.add_development_dependency 'solidus_dev_support', '~> 1.4.0'
  s.add_development_dependency 'timecop', '~> 0.9.1'
  s.add_development_dependency 'with_model', '~> 2.1.2'
end
