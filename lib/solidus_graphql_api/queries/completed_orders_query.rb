# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    class CompletedOrdersQuery
      attr_reader :user

      def initialize(user:)
        @user = user
      end

      def call
        return [] unless user

        user.orders.complete.order :id
      end
    end
  end
end
