# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class ManifestItem < Base::Object
      description 'Shipping Manifest Item.'

      field :variant, Types::Variant, null: false
      field :quantity, Integer, null: false
    end
  end
end
