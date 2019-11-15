# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    class TaxonomiesQuery
      def call
        Spree::Taxonomy.all
      end
    end
  end
end
