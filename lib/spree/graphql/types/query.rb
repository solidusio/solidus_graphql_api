# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Query < Types::Base::Object
        # TODO: remove me
        field :test_field, String, null: false,
          description: "An example field added by the generator"
        def test_field
          "Hello World!"
        end
      end
    end
  end
end
