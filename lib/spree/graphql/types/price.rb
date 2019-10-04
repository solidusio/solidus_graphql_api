# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Price < Base::RelayNode
        description 'Price.'

        field :amount, String, null: false
        field :country_iso, String, null: true
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :currency, String, null: false
        field :currency_symbol, String, null: false
        field :display_amount, String, null: false
        field :display_country, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

        def currency_symbol
          object.display_amount.currency.symbol
        end
      end
    end
  end
end
