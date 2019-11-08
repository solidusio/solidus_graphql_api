# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    class CountriesQuery
      def call
        Spree::Country.all
      end
    end
  end
end
