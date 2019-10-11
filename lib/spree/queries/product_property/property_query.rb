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
          BatchLoader::GraphQL.for(product_property.property_id).batch do |property_ids, loader|
            Spree::Property.where(id: property_ids).each do |property|
              loader.call(property.id, property)
            end
          end
        end
      end
    end
  end
end
