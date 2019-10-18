# frozen_string_literal: true

module Spree
  module Queries
    module ProductProperty
      class PropertyQuery
        attr_reader :product_property

        def initialize(product_property:)
          @product_property = product_property
        end

        def call
          Spree::Graphql::BatchLoader.for(product_property, :property)
        end
      end
    end
  end
end
