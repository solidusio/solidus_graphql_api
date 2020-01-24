# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Currency < Base::RelayNode
      description 'Currency.'

      field :html_entity, String, null: false
      field :iso_code, String, null: false
      field :name, String, null: false
      field :symbol, String, null: false
    end
  end
end
