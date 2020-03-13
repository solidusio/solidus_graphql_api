# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    class BaseMutation < GraphQL::Schema::RelayClassicMutation
      argument_class Types::Base::Argument
      field_class Types::Base::Field
      input_object_class Types::Base::InputObject
      object_class Types::Base::Object

      private

      def current_user
        context[:current_user]
      end

      def current_ability
        context[:current_ability]
      end

      def user_errors(*path, errors)
        return [] if errors.empty?

        errors.map do |attribute, message|
          {
            path: ["input", *path, attribute.to_s.camelize(:lower)],
            message: message,
          }
        end
      end
    end
  end
end
