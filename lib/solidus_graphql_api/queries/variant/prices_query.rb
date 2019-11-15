# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Variant
      class PricesQuery
        attr_reader :variant

        def initialize(variant:)
          @variant = variant
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(variant, :prices)
        end
      end
    end
  end
end
