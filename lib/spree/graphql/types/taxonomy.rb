# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Taxonomy < Base::RelayNode
        description 'Taxonomy.'

        field :name, String, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
