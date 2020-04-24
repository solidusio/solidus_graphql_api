# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class AdvanceCheckout < BaseMutation
        null true

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve
          current_order.contents.advance

          {
            order: current_order.reload,
            errors: user_errors("order", current_order.errors)
          }
        end

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end
      end
    end
  end
end
