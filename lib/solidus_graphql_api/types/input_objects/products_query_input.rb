# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    module InputObjects
      class ProductsQueryInput < Base::InputObject
        description "Params for searching products."

        argument :taxon, ID, "Taxon", required: false, loads: Types::Taxon
        argument :keywords, String, "Keywords", required: false
        argument :search, Types::RansackJson, "Search", required: false
      end
    end
  end
end
