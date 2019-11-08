# frozen_string_literal: true

module Spree
  module Queries
    module Taxonomy
      class TaxonsQuery
        attr_reader :taxonomy

        def initialize(taxonomy:)
          @taxonomy = taxonomy
        end

        def call
          Spree::Graphql::BatchLoader.for(taxonomy, :taxons)
        end
      end
    end
  end
end
