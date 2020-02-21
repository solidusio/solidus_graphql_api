# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Mutation < Base::Object
      field :sign_in, mutation: Mutations::User::SignIn
      field :send_recover_password_instructions, mutation: Mutations::User::SendRecoverPasswordInstructions
    end
  end
end
