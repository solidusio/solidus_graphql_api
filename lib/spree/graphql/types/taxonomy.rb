# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Taxonomy < Base::RelayNode
        description 'Taxonomy.'

        field :name, String, null: false
        field :taxons, Types::Taxon.connection_type, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

        def taxons
          Spree::Queries::Taxonomy::TaxonsQuery.new(taxonomy: object).call
        end
      end
    end
  end
end
