# frozen_string_literal: true

module Spree
  module Queries
    module Address
      class CountryQuery
        attr_reader :address

        def initialize(address:)
          @address = address
        end

        def call
          BatchLoader::GraphQL.for(address.country_id).batch do |country_ids, loader|
            Spree::Country.where(id: country_ids).each do |country|
              loader.call(country.id, country)
            end
          end
        end
      end
    end
  end
end
