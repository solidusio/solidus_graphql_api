# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module User
      class SignUp < BaseMutation
        null true

        argument :email, String, required: true
        argument :password, String, required: true
        argument :password_confirmation, String, required: true

        field :user, Types::User, null: true
        field :errors, [String], null: false

        def resolve(email:, password:, password_confirmation:)
          service = Services::User::SignUp.new
          service.call(email: email, password: password, password_confirmation: password_confirmation)
          { user: service.user, errors: service.errors }
        end
      end
    end
  end
end
