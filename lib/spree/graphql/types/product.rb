# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Product < Base::RelayNode
        description 'Product.'

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :description, String, null: true
        field :master_variant, Types::Variant, null: false
        field :meta_description, String, null: true
        field :meta_keywords, String, null: true
        field :meta_title, String, null: true
        field :name, String, null: false
        field :option_types, Types::OptionType.connection_type, null: false
        field :product_properties, Types::ProductProperty.connection_type, null: false
        field :slug, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
        field :variants, Types::Variant.connection_type, null: false

        def master_variant
          Spree::Queries::Product::MasterVariantQuery.new(product: object).call
        end

        def option_types
          Spree::Queries::Product::OptionTypesQuery.new(product: object).call
        end

        def product_properties
          Spree::Queries::Product::ProductPropertiesQuery.new(product: object).call
        end

        def variants
          Spree::Queries::Product::VariantsQuery.new(product: object).call
        end
      end
    end
  end
end
