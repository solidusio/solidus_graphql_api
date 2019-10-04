# frozen_string_literal: true

module Helpers
  module Graphql
    def execute_query(query, context1: nil)
      JSON.parse(
        Spree::Graphql::Schema.execute(File.read("spec/queries/#{query}.gql"), context: context1).to_json,
        object_class: OpenStruct
      )
    end
  end
end
