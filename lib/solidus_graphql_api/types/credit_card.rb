# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class CreditCard < Base::RelayNode
      description 'Credit Card.'

      field :address, Address, null: false
      field :cc_type, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :last_digits, String, null: false
      field :month, String, null: false
      field :name, String, null: false
      field :payment_method, Types::PaymentMethod, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :year, String, null: false
    end
  end
end
