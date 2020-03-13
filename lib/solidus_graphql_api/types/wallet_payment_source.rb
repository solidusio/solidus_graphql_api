# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class WalletPaymentSource < Base::RelayNode
      description 'Wallet Payment Source.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :default, Boolean, null: false
      field :payment_source, Types::Interfaces::PaymentSource, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
