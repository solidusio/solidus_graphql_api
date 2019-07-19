# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Country < Base::RelayNode
        field :iso_name, String, null: false
        field :iso, String, null: false
        field :iso3, String, null: false
        field :name, String, null: false
        field :numcode, Integer, null: false
        field :states_required, Boolean, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
