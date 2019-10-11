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

        field :products, Types::Product.connection_type,
              null: false,
              description: 'Supported Products.'

        field :taxonomies, Types::Taxonomy.connection_type,
              null: false,
              description: 'Supported Taxonomies.'

        def countries
          Spree::Queries::CountriesQuery.new.call
        end

        def products
          Spree::Queries::ProductsQuery.new.call
        end

        def taxonomies
          Spree::Queries::TaxonomiesQuery.new.call
        end
      end
    end
  end
end
