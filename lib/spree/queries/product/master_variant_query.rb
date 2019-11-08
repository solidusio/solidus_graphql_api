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
          Spree::Graphql::BatchLoader.for(product, :master)
        end
      end
    end
  end
end
