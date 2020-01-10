# frozen_string_literal: true

require 'solidus_dev_support/rake_tasks'
SolidusDevSupport::RakeTasks.install

require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: %w[first_run rubocop extension:specs]

task :first_run do
  Rake::Task['extension:test_app'].invoke if Dir['spec/dummy'].empty?
end

namespace :schema do
  desc 'Dump the schema to JSON and IDL'
  task :dump do
    setup_graphql_rake_tasks

    Rake::Task['graphql:schema:dump'].invoke
  end

  desc 'Dump the schema to IDL in schema.graphql'
  task :idl do
    setup_graphql_rake_tasks

    Rake::Task['graphql:schema:idl'].invoke
  end

  desc 'Dump the schema to JSON in schema.json'
  task :json do
    setup_graphql_rake_tasks

    Rake::Task['graphql:schema:json'].invoke
  end
end

namespace :dev do
  desc 'Setup development app'
  task :setup do
    Rake::Task['extension:test_app'].invoke
    puts "Setting up dummy development database..."

    sh "bin/rails db:drop db:setup spree_sample:load VERBOSE=false RAILS_ENV=development"
  end

  desc 'Start development app'
  task :start do
    sh "./spec/dummy/bin/rails s", verbose: false
  end
end

private

def setup_graphql_rake_tasks
  require 'graphql/rake_task'
  GraphQL::RakeTask.new(schema_name: 'SolidusGraphqlApi::Schema')

  Rake::Task['extension:test_app'].invoke if Dir['spec/dummy'].empty?

  require File.expand_path('spec/dummy/config/environment.rb', __dir__)
end
