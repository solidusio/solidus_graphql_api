# frozen_string_literal: true

module Matchers
  module Graphql
    extend RSpec::Matchers::DSL

    matcher :match_response do |query_result_file|
      match do |actual|
        query_result_path = "spec/support/query_results/#{query_result_file}.json.erb"
        template = File.read(query_result_path)
        json_result = ERB.new(template).result_with_hash(@variables || {})

        @expected = JSON.parse(json_result, object_class: @object_class || Hash, symbolize_names: true)

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
