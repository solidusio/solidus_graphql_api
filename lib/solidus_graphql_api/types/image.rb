# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Image < Base::RelayNode
      description 'Image.'

      field :alt, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :filename, String, null: false
      field :large_url, String, null: false
      field :mini_url, String, null: false
      field :position, Integer, null: false
      field :product_url, String, null: false
      field :small_url, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def large_url; object.url(:large) end

      def mini_url; object.url(:mini) end

      def product_url; object.url(:product) end

      def small_url; object.url(:small) end
    end
  end
end
