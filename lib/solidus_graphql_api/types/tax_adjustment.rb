# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class TaxAdjustment < Base::RelayNode
      implements Types::Interfaces::Adjustment

      description 'TaxAdjustment.'
    end
  end
end
