# frozen_string_literal: true

module SolidusGraphqlApi
  module Services
    module User
      class SendRecoverPasswordInstructions
        def call(email:)
          Spree.user_class.send_reset_password_instructions(email: email).valid?
        end
      end
    end
  end
end
