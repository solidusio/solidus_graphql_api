# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Order
      class LineItemsQuery
        attr_reader :order

        def initialize(order:)
          @order = order
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(order, :line_items)
        end
      end
    end
  end
end
