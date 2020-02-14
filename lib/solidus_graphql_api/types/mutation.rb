# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Mutation < Base::Object
      field :sign_in, mutation: Mutations::User::SignIn
      field :sign_up, mutation: Mutations::User::SignUp
    end
  end
end
