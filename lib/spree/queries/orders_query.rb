# frozen_string_literal: true

module Spree
  module Queries
    class OrdersQuery
      attr_reader :user

      def initialize(user:)
        @user = user
      end

      def call
        return [] unless user

        user.orders.complete
      end
    end
  end
end
