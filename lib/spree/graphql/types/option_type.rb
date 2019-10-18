# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class OptionType < Base::RelayNode
        graphql_name 'OptionType'

        description 'OptionType Type.'

        field :name, String, null: false
        field :presentation, String, null: false
        field :position, Int, null: false
        field :option_values, Types::OptionValue.connection_type, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

        def option_values
          Spree::Queries::OptionType::OptionValuesQuery.new(option_type: object).call
        end
      end
    end
  end
end
