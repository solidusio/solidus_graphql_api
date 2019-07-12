# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Query < Types::Base::Object
        # TODO: remove me
        field :test_field, String, null: false,
          description: "An example field added by the generator"
        def test_field
          "Hello World!"
        end

        # Used by Relay to lookup objects by UUID:
        field :node, field: GraphQL::Relay::Node.field

        # Fetches a list of objects given a list of UUIDs
        field :nodes, field: GraphQL::Relay::Node.plural_field
      end
    end
  end
end
