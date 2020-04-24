# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class ShippingRate < Base::RelayNode
      description 'Shipping Rate.'

      field :cost, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :currency, String, null: false
      field :selected, Boolean, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
