# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :sign_up, mutation: :sign_up do
  let(:email) { "john@example.com" }
  let(:password) { "secret" }
  let(:password_confirmation) { "secret" }

  let(:mutation_variables) {
    {
      input: {
        email: email,
        password: password,
        passwordConfirmation: password_confirmation
      }
    }
  }

  context "when given valid parameters" do
    it { expect(subject[:data][:signUp][:user][:email]).to eq(email) }

    it { expect(subject[:data][:signUp][:errors]).to be_empty }
  end

  context "when given invalid parameters" do
    let(:password_confirmation) { "wrong_password_confirmation" }

    it { expect(subject[:data][:signUp][:user]).to be_nil }

    it { expect(subject[:data][:signUp][:errors]).to eq ["Password Confirmation doesn't match Password"] }
  end
end
