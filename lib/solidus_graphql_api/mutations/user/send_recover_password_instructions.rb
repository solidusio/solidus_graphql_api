# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module User
      class SendRecoverPasswordInstructions < BaseMutation
        null true

        argument :email, String, required: true

        field :message, String, null: false

        def resolve(email:)
          Services::User::SendRecoverPasswordInstructions.new.call(email: email)

          { message: I18n.t('devise.passwords.send_instructions') }
        end
      end
    end
  end
end
