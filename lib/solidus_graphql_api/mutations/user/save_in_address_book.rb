# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module User
      class SaveInAddressBook < BaseMutation
        class AddressTypeInput < Types::Base::Enum
          value "shipping"
          value "billing"
        end

        null true

        argument :address, Types::InputObjects::AddressInput, required: true
        argument :default, Boolean, required: false
        argument :address_type, AddressTypeInput, required: false, default_value: "shipping"

        field :user, Types::User, null: true
        field :errors, [Types::UserError], null: false

        def resolve(address:, address_type:, default: false)
          address = current_user.save_in_address_book(address, default, address_type.to_sym)

          {
            user: current_user,
            errors: user_errors("address", address.errors)
          }
        end

        def ready?(*)
          current_ability.authorize!(:save_in_address_book, current_user)
        end
      end
    end
  end
end
