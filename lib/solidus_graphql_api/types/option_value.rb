# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class OptionValue < Base::RelayNode
      description 'OptionValue.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :name, String, null: false
      field :position, String, null: false
      field :presentation, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :option_type, OptionType, null: false

      def option_type
        Queries::OptionValue::OptionTypeQuery.new(option_value: object).call
      end
    end
  end
end
