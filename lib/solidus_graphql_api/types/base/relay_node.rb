# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    module Base
      class RelayNode < Base::Object
        implements GraphQL::Relay::Node.interface

        global_id_field :id
      end
    end
  end
end
