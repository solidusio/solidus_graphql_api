# frozen_string_literal: true

module SolidusGraphqlApi
  module Services
    module User
      class SignIn
        attr_reader :user

        def call(email:, password:)
          user = Spree.user_class.find_for_authentication(email: email)

          user.present? && user.valid_password?(password).tap do |valid_password|
            @user = valid_password ? user : nil
          end
        end
      end
    end
  end
end
