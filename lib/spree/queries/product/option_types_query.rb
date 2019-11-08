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
          Spree::Graphql::BatchLoader.for(product, :option_types)
        end
      end
    end
  end
end
