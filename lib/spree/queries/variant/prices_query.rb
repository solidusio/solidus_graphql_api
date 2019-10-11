# frozen_string_literal: true

module Spree
  module Queries
    module Variant
      class PricesQuery
        attr_reader :variant

        def initialize(variant:)
          @variant = variant
        end

        def call
          BatchLoader::GraphQL.for(variant.id).batch(default_value: []) do |variant_ids, loader|
            Spree::Price.where(variant_id: variant_ids).each do |price|
              loader.call(price.variant_id) { |memo| memo << price }
            end
          end
        end
      end
    end
  end
end
