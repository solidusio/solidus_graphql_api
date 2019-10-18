# frozen_string_literal: true

module Spree
  module Queries
    module Product
      class OptionTypesQuery
        attr_reader :product

        def initialize(product:)
          @product = product
        end

        def call
          BatchLoader::GraphQL.for(product.id).batch(default_value: []) do |product_ids, loader|
            option_types_by_variant_ids(product_ids).each do |product_id, option_types|
              loader.call(product_id) { |memo| memo.concat(option_types) }
            end
          end
        end

        private

        def option_types_by_variant_ids(product_ids)
          result = Hash.new { |h, k| h[k] = [] }
          Spree::OptionType.includes(:products).where("spree_product_option_types.product_id": product_ids).each do |option_type|
            option_type.products.each { |product| result[product.id] << option_type }
          end
          result
        end
      end
    end
  end
end
