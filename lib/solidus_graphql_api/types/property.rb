# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Property < Base::RelayNode
      description 'Property.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :name, String, null: false
      field :presentation, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
