# frozen_string_literal: true

module Spree
  module Graphql
    class BatchLoader
      # A batch loader for +has_one+ associations.
      class HasOne < BatchLoader
        def load
          graphql_loader_for(object.id) do |object_ids, loader|
            retrieve_records_for(object_ids).each do |record|
              loader.call(record.send(reflection.foreign_key), record)
            end
          end
        end

        private

        def retrieve_records_for(object_ids)
          base_relation.where(reflection.foreign_key => object_ids)
        end
      end
    end
  end
end
