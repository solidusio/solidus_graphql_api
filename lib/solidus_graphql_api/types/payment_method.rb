# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class PaymentMethod < Base::RelayNode
      description 'Payment Method.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :description, String, null: true
      field :name, String, null: false
      field :position, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
