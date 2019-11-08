# frozen_string_literal: true

module Spree
  module Queries
    module Taxonomy
      class RootTaxonQuery
        attr_reader :taxonomy

        def initialize(taxonomy:)
          @taxonomy = taxonomy
        end

        def call
          Spree::Graphql::BatchLoader.for(taxonomy, :root)
        end
      end
    end
  end
end
