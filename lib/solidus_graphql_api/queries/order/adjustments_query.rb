# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Order
      class AdjustmentsQuery
        attr_reader :order

        def initialize(order:)
          @order = order
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(order, :all_adjustments)
        end
      end
    end
  end
end
