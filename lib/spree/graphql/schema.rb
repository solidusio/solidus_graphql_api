# frozen_string_literal: true

module Spree
  module Graphql
    class Schema < GraphQL::Schema
      query Types::Query
    end
  end
end
