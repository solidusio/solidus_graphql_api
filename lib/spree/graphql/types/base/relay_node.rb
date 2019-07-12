# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      module Base
        class RelayNode < Object
          implements GraphQL::Relay::Node.interface

          global_id_field :id
        end
      end
    end
  end
end
