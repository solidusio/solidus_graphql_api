# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Json < GraphQL::Types::JSON
      def self.coerce_input(value, _ctx)
        value.each do |key, field|
          case field
          when String
            value[key] = decode(field)
          when Array
            value[key] = decode_array(field)
          end
        end
        value
      end

      def self.decode(value)
        class_name, item_id = decode_if_relay_id(value)

        return value unless class_exists?(class_name)

        to_i_or_nil(item_id) || value
      end

      def self.decode_array(array)
        array.map do |value|
          value.is_a?(String) ? decode(value) : value
        end
      end

      def self.decode_if_relay_id(value)
        GraphQL::Schema::UniqueWithinType.decode(value)
      rescue ArgumentError
        [nil, nil]
      end

      def self.class_exists?(value)
        return false if value.nil?

        Object.const_defined?(value)
      rescue NameError
        false
      end

      def self.to_i_or_nil(value)
        return value if value.nil?

        Integer(value)
      rescue ArgumentError
        nil
      end
    end
  end
end
