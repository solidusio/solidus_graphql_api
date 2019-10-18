# frozen_string_literal: true

module Spree
  module Queries
    module Product
      class MasterVariantQuery
        attr_reader :product

        def initialize(product:)
          @product = product
        end

        def call
          BatchLoader.for(product.id).batch do |product_ids, loader|
            Spree::Variant.where(is_master: true).where(product_id: product_ids).each do |variant|
              loader.call(variant.product_id, variant)
            end
          end
        end
      end
    end
  end
end
