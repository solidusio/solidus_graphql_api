# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class UpdateCheckoutState < BaseMutation
        null true

        argument :state, String, required: true

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(state:)
          current_order.update(state: state)

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
