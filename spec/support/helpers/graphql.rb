# frozen_string_literal: true

module Helpers
  module Graphql
    def execute_query(query, variables: {}, context: {}, decode_ids: true, object_class: Hash)
      query_result = SolidusGraphqlApi::Schema.execute(
        File.read("spec/support/queries/#{query}.gql"),
        variables: variables,
        context: context
      )

      query_result = decode_field_ids(query_result.to_h) if decode_ids

      JSON.parse(query_result.to_json, object_class: object_class, symbolize_names: true)
    end

    def decode_field_ids(field)
      field.each do |field_name, field_value|
        case field_value
        when String
          if field_name == "id"
            field[field_name] = GraphQL::Schema::UniqueWithinType.decode(field_value).last.to_i
          end
        when Hash
          decode_field_ids field_value
        when Array
          field_value.flatten.each do |child_field|
            decode_field_ids(child_field) if child_field.is_a?(Hash)
          end
        end
      end
      field
    end
  end
end
