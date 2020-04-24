# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Shipment
      class ShippingRatesQuery
        attr_reader :shipment

        def initialize(shipment:)
          @shipment = shipment
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(shipment, :shipping_rates)
        end
      end
    end
  end
end
