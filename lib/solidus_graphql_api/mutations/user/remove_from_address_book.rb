# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module User
      class RemoveFromAddressBook < BaseMutation
        null true

        argument :address_id, ID, required: true, loads: Types::Address

        field :user, Types::User, null: true

        def resolve(address:)
          raise CanCan::AccessDenied unless current_user.remove_from_address_book(address.id)

          { user: current_user.reload }
        end

        def ready?(*)
          current_ability.authorize!(:remove_from_address_book, current_user)
        end
      end
    end
  end
end
