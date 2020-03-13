# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Mutation < Base::Object
      field :sign_in, mutation: Mutations::User::SignIn
      field :save_in_address_book, mutation: Mutations::User::SaveInAddressBook
    end
  end
end
