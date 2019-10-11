# frozen_string_literal: true

module Spree
  module Queries
    module Taxon
      class ParentTaxonQuery
        attr_reader :taxon

        def initialize(taxon:)
          @taxon = taxon
        end

        def call
          BatchLoader::GraphQL.for(taxon.parent_id).batch do |parent_taxon_ids, loader|
            Spree::Taxon.where(id: parent_taxon_ids).each do |parent_taxon|
              loader.call(parent_taxon.id, parent_taxon)
            end
          end
        end
      end
    end
  end
end
