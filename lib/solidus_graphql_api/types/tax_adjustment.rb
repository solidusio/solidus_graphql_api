# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class TaxAdjustment < Base::RelayNode
      description 'TaxAdjustment.'

      field :amount, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :eligible, Boolean, null: false
      field :label, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
