# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Mutation < Base::Object
      field :sign_in, mutation: Mutations::User::SignIn
    end
  end
end
