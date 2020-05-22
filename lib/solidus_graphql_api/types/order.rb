# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Order < Base::RelayNode
      description 'Order.'

      field :additional_tax_total, String, null: false
      field :adjustment_total, String, null: false
      field :approved_at, GraphQL::Types::ISO8601DateTime, null: true
      field :billing_address, Address, null: false
      field :canceled_at, GraphQL::Types::ISO8601DateTime, null: true
      field :completed_at, GraphQL::Types::ISO8601DateTime, null: true
      field :confirmation_delivered, Boolean, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :currency, String, null: false
      field :email, String, null: false
      field :guest_token, String, null: true
      field :included_tax_total, String, null: false
      field :item_total, String, null: false
      field :line_items, LineItem.connection_type, null: false
      field :number, String, null: false
      field :available_payment_methods, [PaymentMethod], null: false
      field :payment_state, String, null: false
      field :payment_total, String, null: false
      field :promo_total, String, null: false
      field :shipment_state, String, null: false
      field :shipment_total, String, null: false
      field :shipments, Shipment.connection_type, null: false
      field :shipping_address, Address, null: false
      field :special_instructions, String, null: true
      field :state, String, null: false
      field :total, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def billing_address
        Queries::Order::BillingAddressQuery.new(order: object).call
      end

      def line_items
        Queries::Order::LineItemsQuery.new(order: object).call
      end

      def shipments
        Queries::Order::ShipmentsQuery.new(order: object).call
      end

      def shipping_address
        Queries::Order::ShippingAddressQuery.new(order: object).call
      end
    end
  end
end
