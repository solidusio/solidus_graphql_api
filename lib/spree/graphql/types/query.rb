# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Query < Types::Base::Object
        # Used by Relay to lookup objects by UUID:
        field :node, field: GraphQL::Relay::Node.field

        # Fetches a list of objects given a list of UUIDs
        field :nodes, field: GraphQL::Relay::Node.plural_field

        field :countries, Types::Country.connection_type,
              null: false,
              description: 'Supported Countries.'

        field :orders, Types::Order.connection_type,
              null: false,
              description: 'Customer Orders.'

        def countries
          Spree::Queries::CountriesQuery.new.call
        end

        def orders
          Spree::Queries::OrdersQuery.new(user: context[:current_user]).call
        end
      end
    end
  end
end
