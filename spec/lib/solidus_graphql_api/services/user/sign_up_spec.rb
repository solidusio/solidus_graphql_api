# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Services::User::SignUp do
  let(:email) { "john@example.com" }
  let(:password) { "secret" }
  let(:password_confirmation) { password }

  subject(:instance) { described_class.new }

  describe "#call" do
    subject { instance.call(email: email, password: password, password_confirmation: password_confirmation) }

    context "when given valid parameters" do
      it { is_expected.to be true }

      context 'instance' do
        before { subject }

        it { expect(instance.user).to be_a_instance_of(Spree.user_class) }

        it { expect(instance.user).to be_valid }

        it { expect(instance.errors).to be_empty }
      end
    end

    context "when given invalid parameters" do
      let(:password_confirmation) { 'wrongpassword' }

      it { is_expected.to be false }

      context 'instance' do
        before { subject }

        it { expect(instance.user).to be_nil }

        it { expect(instance.errors).to be_present }
      end
    end
  end
end
