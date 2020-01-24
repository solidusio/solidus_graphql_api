# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    module Base
      class Object < GraphQL::Schema::Object
        class << self
          # Removes a field from this schema.
          #
          # @param field [Symbol] the field to remove
          #
          # @example Removing a field in a decorator
          #   Spree::Graphql::Types::Variant.remove_field :prices
          def remove_field(field)
            unless own_fields.key?(field.to_s)
              raise ArgumentError, "Field `#{field}` is not defined"
            end

            own_fields.delete(field.to_s)
          end
        end
      end
    end
  end
end
