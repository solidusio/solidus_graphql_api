# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class ProductProperty < Base::RelayNode
        description 'Product Property.'

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :position, Int, null: false
        field :property, Types::Property, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
        field :value, String, null: true

        def property
          Spree::Queries::ProductProperty::PropertyQuery.new(product_property: object).call
        end
      end
    end
  end
end
