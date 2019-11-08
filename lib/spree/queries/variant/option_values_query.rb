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
          Spree::Graphql::BatchLoader.for(variant, :option_values)
        end
      end
    end
  end
end
