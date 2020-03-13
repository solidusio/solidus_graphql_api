# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    module Interfaces
      module PaymentSource
        include Types::Base::Interface

        orphan_types(*SolidusGraphqlApi.configuration.payment_sources)

        description "Payment Source."

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :payment_method, Types::PaymentMethod, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
