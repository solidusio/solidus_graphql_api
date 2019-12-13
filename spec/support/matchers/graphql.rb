# frozen_string_literal: true

module Matchers
  module Graphql
    extend RSpec::Matchers::DSL

    matcher :match_response do |query_result_file|
      match do |actual|
        template = File.read("spec/support/query_results/#{query_result_file}.json.erb")
        json_result = ERB.new(template).result_with_hash(@variables || {})

        @expected = JSON.parse(json_result, object_class: @object_class || OpenStruct)

        actual == @expected
      end

      chain :with_args do |variables|
        @variables = variables
      end

      chain :as do |object_class|
        @object_class = object_class
      end

      failure_message_when_negated do |actual|
        "expected that #{actual} would not be equal of #{expected}"
      end

      diffable
      attr_reader :expected
    end
  end
end
