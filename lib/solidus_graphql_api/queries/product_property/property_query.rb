# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module ProductProperty
      class PropertyQuery
        attr_reader :product_property

        def initialize(product_property:)
          @product_property = product_property
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(product_property, :property)
        end
      end
    end
  end
end
