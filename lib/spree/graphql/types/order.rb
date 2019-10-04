# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Order < Base::RelayNode
        description 'Order.'

        #"user_id"=>nil, "bill_address_id"=>2, "ship_address_id"=>1, "created_by_id"=>nil, "approver_id"=>nil, "canceler_id"=>nil, "store_id"=>1,

        field :approved_at, GraphQL::Types::ISO8601DateTime, null: true
        field :approver_name, String, null: true
        field :canceled_at, GraphQL::Types::ISO8601DateTime, null: true
        field :channel, String, null: true
        field :completed_at, GraphQL::Types::ISO8601DateTime, null: true
        field :confirmation_delivered, Boolean, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :currency, String, null: false
        field :email, String, null: false
        field :frontend_viewable, Boolean, null: false
        field :guest_token, String, null: true
        field :item_count, Integer, null: false
        field :last_ip_address, String, null: true
        field :number, String, null: false
        field :payment_state, String, null: false
        field :shipment_state, String, null: false
        field :special_instructions, String, null: true
        field :state, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
        field :item_total, String, null: false
        field :total, String, null: false
        field :adjustment_total, String, null: false
        field :payment_total, String, null: false
        field :shipment_total, String, null: false
        field :additional_tax_total, String, null: false
        field :promo_total, String, null: false
        field :included_tax_total, String, null: false
      end
    end
  end
end
