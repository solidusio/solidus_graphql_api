# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class CreditCard < Base::RelayNode
      implements Types::Interfaces::PaymentSource

      description 'Credit Card.'

      field :address, Address, null: false
      field :cc_type, String, null: true
      field :last_digits, String, null: false
      field :month, String, null: false
      field :name, String, null: false
      field :year, String, null: false
    end
  end
end
