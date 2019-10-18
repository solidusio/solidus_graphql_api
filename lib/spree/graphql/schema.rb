# frozen_string_literal: true

module Spree
  module Graphql
    class Schema < GraphQL::Schema
      query Types::Query

      use ::BatchLoader::GraphQL

      # Relay Object Identification:
      class << self
        # Return a string UUID for object
        def id_from_object(object, _type_definition, _query_ctx)
          ::GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
        end

        # Given a string UUID, find the object
        def object_from_id(id, _query_ctx)
          class_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)

          ::Object.const_get(class_name).find(item_id)
        end

        # Object Resolution
        def resolve_type(_type_definition, object, _query_ctx)
          Types.const_get(object.class.name.demodulize)
        end
      end
    end
  end
end
