# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module LineItem
      class VariantQuery
        attr_reader :line_item

        def initialize(line_item:)
          @line_item = line_item
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(line_item, :variant)
        end
      end
    end
  end
end
