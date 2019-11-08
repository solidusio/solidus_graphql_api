# frozen_string_literal: true

module SolidusGraphqlApi
  class BatchLoader
    # A batch loader for +has_many+ associations.
    class HasMany < BatchLoader
      def load
        graphql_loader_for(object.id, default_value: []) do |object_ids, loader|
          retrieve_records_for(object_ids).each do |associated_record|
            loader.call(associated_record.send(reflection.foreign_key)) do |memo|
              memo << associated_record
            end
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
