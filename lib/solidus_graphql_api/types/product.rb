# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Product < Base::RelayNode
      description 'Product.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :description, String, null: true
      field :master_variant, Variant, null: false
      field :meta_description, String, null: true
      field :meta_keywords, String, null: true
      field :meta_title, String, null: true
      field :name, String, null: false
      field :option_types, OptionType.connection_type, null: false
      field :product_properties, ProductProperty.connection_type, null: false
      field :slug, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :variants, Variant.connection_type, null: false

      def master_variant
        Queries::Product::MasterVariantQuery.new(product: object).call
      end

      def option_types
        Queries::Product::OptionTypesQuery.new(product: object).call
      end

      def product_properties
        Queries::Product::ProductPropertiesQuery.new(product: object).call
      end

      def variants
        Queries::Product::VariantsQuery.new(product: object).call
      end
    end
  end
end
