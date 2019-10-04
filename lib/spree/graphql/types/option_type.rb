# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class OptionType < Base::RelayNode
        description 'Option Type.'

        field :name, String, null: false
        field :presentation, String, null: false
        field :position, Int, null: false
        field :option_values, Types::OptionValue.connection_type, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
