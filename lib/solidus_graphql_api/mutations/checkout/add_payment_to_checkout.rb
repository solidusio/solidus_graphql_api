# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class AddPaymentToCheckout < BaseMutation
        null true

        argument :payment_method_id, ID, required: true, loads: Types::PaymentMethod
        argument :amount, Float, required: false
        argument :source, GraphQL::Types::JSON, required: false

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(payment_method:, amount: nil, source:)
          current_order.update(state: :payment)

          update_params = {
            payments_attributes: [{
              payment_method_id: payment_method.id,
              amount: amount || current_order.total,
              source_attributes: source
            }]
          }

          Spree::OrderUpdateAttributes.new(current_order, update_params).apply

          {
            errors: user_errors('order', current_order.errors),
            order: current_order.reload
          }
        end

        private

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end
      end
    end
  end
end
