# frozen_string_literal: true

module SolidusGraphqlApi
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'solidus_graphql_api'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.eager_load_paths << File.expand_path('..', __dir__)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
