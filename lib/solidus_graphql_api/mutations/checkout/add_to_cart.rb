# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class AddToCart < BaseMutation
        null true

        argument :variant_id, ID, required: true, loads: Types::Variant
        argument :quantity, Integer, required: true

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(variant:, quantity:)
          line_item = current_order.contents.add(variant, quantity)

          {
            order: current_order,
            errors: user_errors("line_item", line_item.errors)
          }
        end

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end
      end
    end
  end
end
