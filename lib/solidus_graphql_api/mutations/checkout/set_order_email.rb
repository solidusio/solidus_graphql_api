# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class SetOrderEmail < BaseMutation
        null true

        argument :email, String, required: true

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(email:)
          current_order.update(email: email)

          {
            order: current_order,
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
