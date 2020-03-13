# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module User
      class SaveInAddressBook < BaseMutation
        null true

        argument :address, Types::InputObjects::AddressInput, required: true
        argument :default, Boolean, required: false

        field :user, Types::User, null: true
        field :errors, [Types::UserError], null: false

        def resolve(address:, default: false)
          address = current_user.save_in_address_book(address, default)

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
