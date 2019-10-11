# frozen_string_literal: true

module Spree
  module Queries
    module Product
      class VariantsQuery
        attr_reader :product

        def initialize(product:)
          @product = product
        end

        def call
          BatchLoader::GraphQL.for(product.id).batch(default_value: []) do |product_ids, loader|
            Spree::Variant.where(product_id: product_ids, is_master: false).each do |variant|
              loader.call(variant.product_id) { |memo| memo << variant }
            end
          end
        end
      end
    end
  end
end
