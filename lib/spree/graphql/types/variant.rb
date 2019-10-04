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
        field :sku, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
        field :weight, String, null: false
        field :width, String, null: true
      end
    end
  end
end
