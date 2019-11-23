# frozen_string_literal: true

module Helpers
  module Graphql
    def execute_query(query, variables: {}, context:)
      JSON.parse(
        SolidusGraphqlApi::Schema.execute(
          File.read("spec/support/queries/#{query}.gql"),
          variables: variables,
          context: context
        ).to_json,
        object_class: OpenStruct
      )
    end
  end
end
