# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Query < Base::Object
      # Used by Relay to lookup objects by UUID:
      field :node, field: GraphQL::Relay::Node.field

      # Fetches a list of objects given a list of UUIDs
      field :nodes, field: GraphQL::Relay::Node.plural_field

      field :countries, Country.connection_type,
            null: false,
            description: 'Supported Countries.'

      field :products, Product.connection_type,
            null: false,
            description: 'Supported Products.'

      field :product_by_slug, Product,
            null: true,
            description: 'Find a product by its slug.' do
              argument :slug, String, required: true
            end

      field :taxonomies, Taxonomy.connection_type,
            null: false,
            description: 'Supported Taxonomies.'

      field :current_user, Types::User,
            null: true,
            description: 'Current logged User.'

      field :current_store, Types::Store,
            null: true,
            description: 'Current Store.'

      def countries
        Queries::CountriesQuery.new.call
      end

      def products
        Queries::ProductsQuery.new.call
      end

      def product_by_slug(slug:)
        Queries::ProductBySlugQuery.new.call(slug: slug)
      end

      def taxonomies
        Queries::TaxonomiesQuery.new.call
      end

      def current_user
        context[:current_user]
      end

      def current_store
        context[:current_store]
      end
    end
  end
end
