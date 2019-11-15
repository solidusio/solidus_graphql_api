# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Product
      class OptionTypesQuery
        attr_reader :product

        def initialize(product:)
          @product = product
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(product, :option_types)
        end
      end
    end
  end
end
