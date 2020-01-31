# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module User
      class SignIn < BaseMutation
        null true

        argument :email, String, required: true
        argument :password, String, required: true

        field :user, Types::User, null: true
        field :errors, [String], null: false

        def resolve(email:, password:)
          service = Services::User::SignIn.new

          errors = service.call(email: email, password: password) ? [] : [I18n.t('devise.failure.invalid')]

          { user: service.user, errors: errors }
        end
      end
    end
  end
end
