# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Country
      class StatesQuery
        attr_reader :country

        def initialize(country:)
          @country = country
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(country, :states)
        end
      end
    end
  end
end
