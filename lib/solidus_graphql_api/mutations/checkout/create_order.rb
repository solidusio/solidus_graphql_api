# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class CreateOrder < BaseMutation
        null true

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve
          order = Spree::Order.create!(user: current_user, store: current_store)

          {
            order: order,
            errors: user_errors("order", order.errors)
          }
        end

        def ready?(*)
          current_ability.authorize!(:create, Spree::Order)
        end
      end
    end
  end
end
