# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Shipment < Base::RelayNode
      description 'Order Shipment.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :number, String, null: false
      field :shipped_at, GraphQL::Types::ISO8601DateTime, null: true
      field :shipping_rates, ShippingRate.connection_type, null: false
      field :state, String, null: false
      field :tracking, String, null: true
      field :tracking_url, String, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def shipping_rates
        Queries::Shipment::ShippingRatesQuery.new(shipment: object).call
      end
    end
  end
end
