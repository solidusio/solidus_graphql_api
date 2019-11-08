# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Taxon
      class ParentTaxonQuery
        attr_reader :taxon

        def initialize(taxon:)
          @taxon = taxon
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(taxon, :parent)
        end
      end
    end
  end
end
