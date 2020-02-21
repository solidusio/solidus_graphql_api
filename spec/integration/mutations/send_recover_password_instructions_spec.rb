# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :send_recover_password_instructions, mutation: :send_recover_password_instructions do
  let(:email) { "john@example.com" }

  let(:mutation_variables) { Hash[input: { email: email }] }

  let(:message) { subject[:data][:sendRecoverPasswordInstructions][:message] }

  context "when given an email" do
    it { expect(message).to eq I18n.t('devise.passwords.send_instructions') }
  end

  context "when not given an email" do
    let(:email) { "" }

    it { expect(message).to eq I18n.t('devise.passwords.send_instructions') }
  end

  context "when given a wrong email" do
    let(:email) { "wrongemail" }

    it { expect(message).to eq I18n.t('devise.passwords.send_instructions') }
  end
end
