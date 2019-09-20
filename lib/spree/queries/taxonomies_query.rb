# frozen_string_literal: true

module Spree
  module Queries
    class TaxonomiesQuery
      def call
        Spree::Taxonomy.all
      end
    end
  end
end
