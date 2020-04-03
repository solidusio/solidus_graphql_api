# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Shipment < Base::RelayNode
      description 'Order Shipment.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :number, String, null: false
      field :shipped_at, GraphQL::Types::ISO8601DateTime, null: true
      field :state, String, null: false
      field :tracking, String, null: true
      field :tracking_url, String, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
