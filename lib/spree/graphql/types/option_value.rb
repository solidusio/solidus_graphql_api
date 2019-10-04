# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class OptionValue < Base::RelayNode
        description 'OptionValue.'

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :name, String, null: false
        field :position, String, null: false
        field :presentation, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
