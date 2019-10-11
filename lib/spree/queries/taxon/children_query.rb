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
          BatchLoader::GraphQL.for(taxon.id).batch(default_value: []) do |taxon_ids, loader|
            Spree::Taxon.where(parent_id: taxon_ids).each do |children|
              loader.call(children.parent_id) { |memo| memo << children }
            end
          end
        end
      end
    end
  end
end
