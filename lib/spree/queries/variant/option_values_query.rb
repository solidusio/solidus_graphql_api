# frozen_string_literal: true

module Spree
  module Queries
    module Variant
      class OptionValuesQuery
        attr_reader :variant

        def initialize(variant:)
          @variant = variant
        end

        def call
          BatchLoader::GraphQL.for(variant.id).batch(default_value: []) do |variant_ids, loader|
            option_values_by_variant_ids(variant_ids).each do |variant_id, option_values|
              loader.call(variant_id) { |memo| memo.concat(option_values) }
            end
          end
        end

        def option_values_by_variant_ids(variant_ids)
          result = Hash.new { |h, k| h[k] = [] }
          Spree::OptionValue.includes(:variants).where("spree_option_values_variants.variant_id": variant_ids).each do |option_value|
            option_value.variants.each { |variant| result[variant.id] << option_value }
          end
          result
        end
      end
    end
  end
end
