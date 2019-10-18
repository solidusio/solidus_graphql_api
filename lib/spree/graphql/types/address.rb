# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Address < Base::RelayNode
        description 'Address.'

        field :address1, String, null: true
        field :address2, String, null: true
        field :alternative_phone, String, null: true
        field :city, String, null: true
        field :company, String, null: true
        field :country, Types::Country, null: true
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :firstname, String, null: true
        field :lastname, String, null: true
        field :phone, String, null: true
        field :state_name, String, null: true
        field :state, Types::State, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
        field :zipcode, String, null: true

        def state
          Spree::Queries::Address::StateQuery.new(address: object).call
        end

        def country
          Spree::Queries::Address::CountryQuery.new(address: object).call
        end
      end
    end
  end
end
