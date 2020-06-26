# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class AddAddressesToCheckout < BaseMutation
        null true

        argument :billing_address, Types::InputObjects::AddressInput, required: true
        argument :shipping_address, Types::InputObjects::AddressInput, required: false
        argument :ship_to_billing_address, Boolean, required: false

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(billing_address:, shipping_address: nil, ship_to_billing_address: false)
          current_order.update(state: :address)

          update_params = {
            bill_address: Spree::Address.new(billing_address.to_h),
            ship_address: Spree::Address.new(shipping_address.to_h),
            use_billing: ship_to_billing_address
          }

          if Spree::OrderUpdateAttributes.new(current_order, update_params).apply
            current_order.recalculate
            errors = []
          else
            errors = current_order.errors
          end

          { errors: user_errors('order', errors), order: current_order }
        end

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end
      end
    end
  end
end
