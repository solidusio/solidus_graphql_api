# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Price < Base::RelayNode
      description 'Price.'

      field :amount, String, null: false
      field :country_iso, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :currency, Currency, null: false
      field :display_amount, String, null: false
      field :display_country, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def currency
        object.display_amount.currency
      end
    end
  end
end
