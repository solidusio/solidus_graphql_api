# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Variant < Base::RelayNode
      description 'Variant.'

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :default_price, Price, null: false
      field :depth, String, null: true
      field :height, String, null: true
      field :images, Types::Image.connection_type, null: false
      field :is_master, Boolean, null: false
      field :option_values, OptionValue.connection_type, null: false
      field :position, Int, null: false
      field :prices, Price.connection_type, null: false
      field :sku, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :weight, String, null: false
      field :width, String, null: true
      field :product, Types::Product, null: false

      def default_price
        Queries::Variant::DefaultPriceQuery.new(variant: object).call
      end

      def images
        Queries::Variant::ImagesQuery.new(variant: object).call
      end

      def option_values
        Queries::Variant::OptionValuesQuery.new(variant: object).call
      end

      def prices
        Queries::Variant::PricesQuery.new(variant: object).call
      end
    end
  end
end
