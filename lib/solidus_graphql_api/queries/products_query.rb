# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    class ProductsQuery
      def call
        Spree::Product.all
      end
    end
  end
end
