# frozen_string_literal: true

module Spree
  module Queries
    module Variant
      class DefaultPriceQuery
        attr_reader :variant

        def initialize(variant:)
          @variant = variant
        end

        def call
          BatchLoader.for(variant.id).batch do |variant_ids, loader|
            Spree::Price.with_default_attributes.where(variant_id: variant_ids).each do |price|
              loader.call(price.variant_id, price)
            end
          end
        end
      end
    end
  end
end
