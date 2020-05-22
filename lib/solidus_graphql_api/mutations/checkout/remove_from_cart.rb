# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class RemoveFromCart < BaseMutation
        null true

        argument :line_item_id, ID, required: true, loads: Types::LineItem

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(line_item:)
          line_item = current_order.contents.remove_line_item(line_item)

          {
            order: current_order,
            errors: user_errors("line_item", line_item.errors)
          }
        end

        def authorized?(line_item:)
          current_order.line_items.find(line_item.id)
        end

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end
      end
    end
  end
end
