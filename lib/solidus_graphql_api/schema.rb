# frozen_string_literal: true

module SolidusGraphqlApi
  class Schema < GraphQL::Schema
    query Types::Query
    mutation Types::Mutation

    use ::BatchLoader::GraphQL

    rescue_from CanCan::AccessDenied do |exception|
      raise GraphQL::ExecutionError, exception.message
    end

    rescue_from ActiveRecord::RecordNotFound do
      raise GraphQL::ExecutionError, I18n.t(:'activerecord.exceptions.not_found')
    end

    # Relay Object Identification:
    class << self
      # Return a string UUID for object
      def id_from_object(object, _type_definition, _query_ctx)
        GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
      end

      # Given a string UUID, find the object
      def object_from_id(id, _query_ctx)
        class_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)

        ::Object.const_get(class_name).find(item_id)
      end

      # Object Resolution
      def resolve_type(_type_definition, object, _query_ctx)
        class_name = object.is_a?(Spree::PaymentMethod) ? "PaymentMethod" : object.class.name.demodulize

        Types.const_get(class_name)
      end
    end
  end
end
