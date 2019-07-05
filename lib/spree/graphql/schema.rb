# frozen_string_literal: true

module Spree
  module Graphql
    class Schema < GraphQL::Schema
      query(Types::QueryType)
    end
  end
end
