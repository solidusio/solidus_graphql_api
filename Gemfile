# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |name| "https://github.com/#{name}.git" }

solidus_branch = ENV.fetch('SOLIDUS_BRANCH', 'master')

gem 'solidus', github: 'solidusio/solidus', branch: solidus_branch
# Provides basic authentication functionality for testing parts of your engine
gem 'solidus_auth_devise'

case ENV['DB']
when 'mysql'
  gem 'mysql2', '~> 0.4.10'
when 'postgresql'
  gem 'pg', '~> 0.21'
end

# Add your own local gems
local_gemfile = File.expand_path('.Gemfile', __dir__)
instance_eval File.read local_gemfile if File.exist? local_gemfile

gemspec
