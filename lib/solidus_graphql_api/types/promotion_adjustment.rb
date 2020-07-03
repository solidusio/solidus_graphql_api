# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class PromotionAdjustment < Base::RelayNode
      description 'PromotionAdjustment.'

      field :amount, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :eligible, Boolean, null: false
      field :label, String, null: false
      field :promotion_code, String, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def promotion_code
        object.promotion_code&.value
      end
    end
  end
end
