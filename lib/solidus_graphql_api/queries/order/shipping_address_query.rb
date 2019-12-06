# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Order
      class ShippingAddressQuery
        attr_reader :order

        def initialize(order:)
          @order = order
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(order, :ship_address)
        end
      end
    end
  end
end
