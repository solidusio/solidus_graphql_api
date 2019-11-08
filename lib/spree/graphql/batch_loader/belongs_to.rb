# frozen_string_literal: true

module Spree
  module Graphql
    class BatchLoader
      # A batch loader for +belongs_to+ associations.
      class BelongsTo < BatchLoader
        def load
          graphql_loader_for(object.send(reflection.foreign_key)) do |object_ids, loader|
            retrieve_records_for(object_ids).each do |record|
              loader.call(record.send(association_primary_key), record)
            end
          end
        end

        private

        def retrieve_records_for(object_ids)
          base_relation.where(association_primary_key => object_ids)
        end

        def association_primary_key
          if reflection.polymorphic?
            association_klass.primary_key
          else
            reflection.association_primary_key
          end
        end
      end
    end
  end
end
