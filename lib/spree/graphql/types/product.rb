# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Product < Base::RelayNode
        description 'Product.'

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :description, String, null: true
        field :meta_description, String, null: true
        field :meta_keywords, String, null: true
        field :meta_title, String, null: true
        field :name, String, null: false
        field :slug, String, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
