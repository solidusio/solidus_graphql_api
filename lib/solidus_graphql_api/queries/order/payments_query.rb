# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Order
      class PaymentsQuery
        attr_reader :order

        def initialize(order:)
          @order = order
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(order, :payments)
        end
      end
    end
  end
end
