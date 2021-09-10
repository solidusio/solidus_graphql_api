# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module OptionValue
      class OptionTypeQuery
        attr_reader :option_value

        def initialize(option_value:)
          @option_value = option_value
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(option_value, :option_type)
        end
      end
    end
  end
end
