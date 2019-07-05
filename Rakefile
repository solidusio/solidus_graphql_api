# frozen_string_literal: true

require 'bundler'

Bundler::GemHelper.install_tasks

begin
  require 'spree/testing_support/extension_rake'
  require 'rubocop/rake_task'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  RuboCop::RakeTask.new

  task default: %i(first_run rubocop spec)
rescue LoadError
  puts 'no rspec available'
end

task :first_run do
  if Dir['spec/dummy'].empty?
    Rake::Task[:test_app].invoke
    Dir.chdir('../../')
  end
end

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'solidus_graphql_api'
  Rake::Task['extension:test_app'].invoke
end

namespace :dev do
  desc 'Setup development app'
  task :setup do
    Rake::Task['test_app'].invoke
    puts "Setting up dummy development database..."

    sh "bin/rails db:drop db:setup spree_sample:load VERBOSE=false RAILS_ENV=development"
  end

  desc 'Start development app'
  task :start do
    sh "./spec/dummy/bin/rails s", verbose: false
  end
end
