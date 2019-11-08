# frozen_string_literal: true

module Spree
  module Queries
    module Taxon
      class ChildrenQuery
        attr_reader :taxon

        def initialize(taxon:)
          @taxon = taxon
        end

        def call
          Spree::Graphql::BatchLoader.for(taxon, :children)
        end
      end
    end
  end
end
