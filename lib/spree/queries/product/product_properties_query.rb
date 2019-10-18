# frozen_string_literal: true

module Spree
  module Queries
    module Product
      class ProductPropertiesQuery
        attr_reader :product

        def initialize(product:)
          @product = product
        end

        def call
          BatchLoader::GraphQL.for(product.id).batch(default_value: []) do |product_ids, loader|
            Spree::ProductProperty.where(product_id: product_ids).each do |product_property|
              loader.call(product_property.product_id) { |memo| memo << product_property }
            end
          end
        end
      end
    end
  end
end
