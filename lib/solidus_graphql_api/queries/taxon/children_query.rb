# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Taxon
      class ChildrenQuery
        attr_reader :taxon

        def initialize(taxon:)
          @taxon = taxon
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(taxon, :children, scope: Spree::Taxon.order(:id))
        end
      end
    end
  end
end
