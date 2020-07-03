# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class PromotionAdjustment < Base::RelayNode
      implements Types::Interfaces::Adjustment

      description 'PromotionAdjustment.'

      field :promotion_code, String, null: true

      def promotion_code
        object.promotion_code&.value
      end
    end
  end
end
