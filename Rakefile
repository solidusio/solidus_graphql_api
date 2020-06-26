# frozen_string_literal: true

require 'solidus_dev_support/rake_tasks'
SolidusDevSupport::RakeTasks.install

require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: %w[rubocop extension:specs]

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

private

def setup_graphql_rake_tasks
  require 'graphql/rake_task'
  GraphQL::RakeTask.new(schema_name: 'SolidusGraphqlApi::Schema')

  Rake::Task['extension:test_app'].invoke if Dir['spec/dummy'].empty?

  require File.expand_path('spec/dummy/config/environment.rb', __dir__)
end
