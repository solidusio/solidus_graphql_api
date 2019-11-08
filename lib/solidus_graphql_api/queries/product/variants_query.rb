# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Product
      class VariantsQuery
        attr_reader :product

        def initialize(product:)
          @product = product
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(product, :variants)
        end
      end
    end
  end
end
