# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

# Run Coverage report
require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('dummy/config/environment.rb', __dir__)

# Requires factories and other useful helpers defined in spree_core.
require 'solidus_dev_support/rspec/rails_helper'
require 'pry'
require "graphql/schema_comparator"
require 'with_model'
require 'timecop'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

# Requires factories defined in lib/solidus_graphql_api/factories.rb
require 'solidus_graphql_api/factories'

RSpec.configure do |config|
  DEFAULT_FREEZE_DATE = "21/12/2012 12:00:00"

  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
  config.include Helpers::Graphql
  config.include Matchers::Graphql

  # They can be used in the specs to explain better the result of a Graphql query.
  config.alias_example_group_to :describe_query, type: :graphql_query
  config.alias_example_group_to :connection_field, type: :graphql_query
  config.alias_example_group_to :field, type: :graphql_query

  config.before(:each) do
    BatchLoader::Executor.clear_current
  end

  config.around(:each, type: :graphql_query) do |example|
    freeze_date = example.metadata[:freeze_date]

    if freeze_date
      Timecop.freeze(DateTime.parse(freeze_date.is_a?(String) ? freeze_date : DEFAULT_FREEZE_DATE))
      example.run
      Timecop.return
    else
      example.run
    end
  end

  config.extend WithModel
end
