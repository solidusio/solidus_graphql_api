# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Address < Base::RelayNode
      description 'Address.'

      field :address1, String, null: true
      field :address2, String, null: true
      field :alternative_phone, String, null: true
      field :city, String, null: true
      field :company, String, null: true
      field :country, Country, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :firstname, String, null: true
      field :lastname, String, null: true
      field :phone, String, null: true
      field :state_name, String, null: true
      field :state, State, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :zipcode, String, null: true

      def state
        Queries::Address::StateQuery.new(address: object).call
      end

      def country
        Queries::Address::CountryQuery.new(address: object).call
      end
    end
  end
end
