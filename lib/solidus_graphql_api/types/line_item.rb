# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class LineItem < Base::RelayNode
      description 'Line item.'

      field :additional_tax_total, Float, null: false
      field :adjustment_total, Float, null: false
      field :amount, Float, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :currency, String, null: false
      field :has_sufficient_stock, Boolean, null: false, method: :sufficient_stock?
      field :included_tax_total, Float, null: false
      field :price, Float, null: false
      field :promo_total, Float, null: false
      field :quantity, Integer, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :variant, Variant, null: false

      def variant
        Queries::LineItem::VariantQuery.new(line_item: object).call
      end
    end
  end
end
