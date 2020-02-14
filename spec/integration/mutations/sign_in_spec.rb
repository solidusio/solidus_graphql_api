# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :sign_in, mutation: :sign_in do
  let(:email) { "john@example.com" }
  let(:password) { "secret" }

  let(:mutation_variables) {
    {
      input: {
        email: email,
        password: password
      }
    }
  }

  context "when given valid credentials" do
    let!(:user) { create(:user, email: email, password: password) }

    it { expect(subject[:data][:signIn][:user][:email]).to eq(email) }

    it { expect(subject[:data][:signIn][:errors]).to be_empty }
  end

  context "when given invalid credentials" do
    it { expect(subject[:data][:signIn][:user]).to be_nil }

    it { expect(subject[:data][:signIn][:errors]).to eq ["Invalid email or password."] }
  end
end
