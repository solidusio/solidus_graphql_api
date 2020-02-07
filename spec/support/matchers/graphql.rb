# frozen_string_literal: true

module Matchers
  module Graphql
    extend RSpec::Matchers::DSL

    matcher :match_response do |query_response_file|
      match do |actual|
        query_response_path = File.join(RSpec.configuration.graphql_responses_dir, "#{query_response_file}.json.erb")
        template = File.read(query_response_path)
        json_response = ERB.new(template).result_with_hash(@variables || {})

        @expected = JSON.parse(json_response, object_class: @object_class || Hash, symbolize_names: true)

        # Lets the failure message have a nice diff
        @expected = JSON.pretty_generate @expected
        @actual = JSON.pretty_generate actual

        @actual == @expected
      end

      chain :with_args do |variables|
        @variables = variables
      end

      chain :as do |object_class|
        @object_class = object_class
      end

      diffable

      attr_reader :expected
    end
  end
end
