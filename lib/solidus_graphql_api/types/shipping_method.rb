# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class ShippingMethod < Base::RelayNode
      description 'Shipping Method.'

      field :name, String, null: false
      field :tracking_url, String, null: true
      field :admin_name, String, null: true
      field :code, String, null: true
      field :carrier, String, null: true
      field :service_level, String, null: true
      field :available_to_users, Boolean, null: false
      field :available_to_all, Boolean, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
