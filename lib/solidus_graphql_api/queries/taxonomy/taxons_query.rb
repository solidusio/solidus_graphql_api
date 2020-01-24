# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Taxonomy
      class TaxonsQuery
        attr_reader :taxonomy

        def initialize(taxonomy:)
          @taxonomy = taxonomy
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(taxonomy, :taxons, scope: Spree::Taxon.order(:position, :id))
        end
      end
    end
  end
end
