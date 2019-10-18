# frozen_string_literal: true

module Spree
  module Queries
    module Address
      class StateQuery
        attr_reader :address

        def initialize(address:)
          @address = address
        end

        def call
          BatchLoader::GraphQL.for(address.state_id).batch do |state_ids, loader|
            Spree::State.where(id: state_ids).each do |state|
              loader.call(state.id, state)
            end
          end
        end
      end
    end
  end
end
