# frozen_string_literal: true

module Spree
  module Queries
    module Country
      class StatesQuery
        attr_reader :country

        def initialize(country:)
          @country = country
        end

        def call
          Spree::Graphql::BatchLoader.for(country, :states)
        end
      end
    end
  end
end
