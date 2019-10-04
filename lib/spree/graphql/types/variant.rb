# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Variant < Base::RelayNode
        description 'Variant.'

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :depth, String, null: true
        field :height, String, null: true
        field :is_master, Boolean, null: false
        field :position, Int, null: false
        field :prices, Types::Price.connection_type, null: false
        field :sku, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
        field :weight, String, null: false
        field :width, String, null: true

        def prices
          Spree::Queries::Variant::PricesQuery.new(variant: object).call
        end
      end
    end
  end
end
