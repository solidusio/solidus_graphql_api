# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    class ProductsQuery
      attr_reader :user, :pricing_options

      def initialize(user:, pricing_options:)
        @user = user
        @pricing_options = pricing_options
      end

      def call(query: {})
        Spree::Config.searcher_class.new(query).tap do |searcher|
          searcher.current_user = user
          searcher.pricing_options = pricing_options
        end.retrieve_products.except(:limit, :offset)
      end
    end
  end
end
