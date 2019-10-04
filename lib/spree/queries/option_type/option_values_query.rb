# frozen_string_literal: true

module Spree
  module Queries
    module OptionType
      class OptionValuesQuery
        attr_reader :option_type

        def initialize(option_type:)
          @option_type = option_type
        end

        def call
          BatchLoader::GraphQL.for(option_type.id).batch(default_value: []) do |option_type_ids, loader|
            Spree::OptionValue.where(option_type_id: option_type_ids).each do |option_value|
              loader.call(option_value.option_type_id) { |memo| memo << option_value }
            end
          end
        end
      end
    end
  end
end
