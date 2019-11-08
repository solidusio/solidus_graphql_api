# frozen_string_literal: true

module Helpers
  module Graphql
    def execute_query(query, context:)
      JSON.parse(
        SolidusGraphqlApi::Schema.execute(
          File.read("spec/queries/#{query}.gql"),
          context: context
        ).to_json,
        object_class: OpenStruct
      )
    end
  end
end
