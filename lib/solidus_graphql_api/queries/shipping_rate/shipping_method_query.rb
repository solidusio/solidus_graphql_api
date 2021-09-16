# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module ShippingRate
      class ShippingMethodQuery
        attr_reader :shipping_rate

        def initialize(shipping_rate:)
          @shipping_rate = shipping_rate
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(shipping_rate, :shipping_method)
        end
      end
    end
  end
end
