# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module OptionType
      class OptionValuesQuery
        attr_reader :option_type

        def initialize(option_type:)
          @option_type = option_type
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(option_type, :option_values)
        end
      end
    end
  end
end
