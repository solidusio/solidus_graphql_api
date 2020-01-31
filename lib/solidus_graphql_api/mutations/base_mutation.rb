# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    class BaseMutation < GraphQL::Schema::RelayClassicMutation
      argument_class Types::Base::Argument
      field_class Types::Base::Field
      input_object_class Types::Base::InputObject
      object_class Types::Base::Object
    end
  end
end
