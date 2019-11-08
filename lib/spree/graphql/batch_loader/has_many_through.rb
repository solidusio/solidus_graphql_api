# frozen_string_literal: true

module Spree
  module Graphql
    class BatchLoader
      # A batch loader for +has_many :through+ associations.
      class HasManyThrough < BatchLoader
        def load
          graphql_loader_for(object.id, default_value: []) do |object_ids, loader|
            records_by_parent = group_records_by_parent(retrieve_records_for(object_ids))

            records_by_parent.each_pair do |parent_id, children|
              loader.call(parent_id) do |memo|
                memo.concat(children)
              end
            end
          end
        end

        private

        def retrieve_records_for(object_ids)
          through_reflection = reflection.through_reflection

          base_relation
            .joins(through_reflection.name)
            .where("#{through_reflection.table_name}.#{through_reflection.foreign_key}" => object_ids)
        end

        def group_records_by_parent(records)
          result = Hash.new { |h, k| h[k] = [] }

          records.each do |record|
            record.send(reflection.through_reflection.name).each do |parent|
              result[parent.send(reflection.through_reflection.foreign_key)] << record
            end
          end

          result
        end
      end
    end
  end
end
