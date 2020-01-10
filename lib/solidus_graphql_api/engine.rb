# frozen_string_literal: true

require 'spree/core'

module SolidusGraphqlApi
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions::Decorators

    isolate_namespace Spree

    engine_name 'solidus_graphql_api'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths << File.expand_path('..', __dir__)
  end
end
