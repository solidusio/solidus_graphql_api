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
          BatchLoader::GraphQL.for(taxonomy.id).batch(default_value: []) do |taxonomy_ids, loader|
            Spree::Taxon.where(taxonomy_id: taxonomy_ids).each do |taxon|
              loader.call(taxon.taxonomy_id) { |memo| memo << taxon }
            end
          end
        end
      end
    end
  end
end
