# frozen_string_literal: true

module SolidusGraphqlApi
  module Services
    module User
      class SignUp
        attr_reader :user, :errors

        def call(email:, password:, password_confirmation:)
          @user = Spree.user_class.new(
            email: email,
            password: password,
            password_confirmation: password_confirmation
          )

          @user.save.tap { @errors = @user.errors.full_messages }
        end
      end
    end
  end
end
