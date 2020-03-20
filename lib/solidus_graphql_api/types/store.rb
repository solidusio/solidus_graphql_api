# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Store < Base::RelayNode
      description 'Store.'

      field :cart_tax_country_iso, String, null: true
      field :code, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :currencies, Currency.connection_type, null: false
      field :default_currency, String, null: true
      field :default, Boolean, null: false
      field :mail_from_address, String, null: false
      field :meta_description, String, null: true
      field :meta_keywords, String, null: true
      field :name, String, null: false
      field :seo_title, String, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :url, String, null: false

      def currencies
        Spree::Config.available_currencies
      end
    end
  end
end
