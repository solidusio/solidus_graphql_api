# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Order
      class ShipmentsQuery
        attr_reader :order

        def initialize(order:)
          @order = order
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(order, :shipments)
        end
      end
    end
  end
end
