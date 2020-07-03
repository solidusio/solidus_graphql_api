# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    module Interfaces
      module Adjustment
        include Types::Base::Interface

        description "Adjustment."

        orphan_types Types::TaxAdjustment, Types::PromotionAdjustment

        field :amount, String, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :eligible, Boolean, null: false
        field :label, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

        definition_methods do
          def resolve_type(object, _context)
            case object.source_type
            when Spree::TaxRate.to_s
              Types::TaxAdjustment
            when Spree::PromotionAction.to_s
              Types::PromotionAdjustment
            end
          end
        end
      end
    end
  end
end
