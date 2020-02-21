# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Services::User::SendRecoverPasswordInstructions do
  subject(:instance) { described_class.new }

  let(:email) { 'solidus@solidus.io' }

  before do
    allow(Spree.user_class).to receive(:send_reset_password_instructions).
      with(email: email).
      and_return(double(valid?: valid))
  end

  describe "#call" do
    subject { instance.call(email: email) }

    context "when a valid email is given" do
      let(:valid) { true }

      it { is_expected.to be true }
    end

    context "when an invalid email given" do
      let(:valid) { false }

      it { is_expected.to be false }
    end
  end
end
