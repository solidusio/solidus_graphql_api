# frozen_string_literal: true

module Spree
  module Queries
    class StatesQuery
      attr_reader :country

      def initialize(country)
        @country = country
      end

      def call
        BatchLoader::GraphQL.for(country.id).batch(default_value: []) do |country_ids, loader|
          Spree::State.where(country_id: country_ids).each do |state|
            loader.call(state.country_id) { |memo| memo << state }
          end
        end
      end
    end
  end
end
