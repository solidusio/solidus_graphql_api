# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Services::User::SignIn do
  let(:email) { "john@example.com" }
  let(:password) { "secret" }

  let!(:user) { create(:user, email: "john@example.com", password: "secret") }

  subject(:instance) { described_class.new }

  describe "#call" do
    subject { instance.call(email: email, password: password) }

    context "when given valid credentials" do
      it { is_expected.to be true }

      context 'instance' do
        before { subject }

        it { expect(instance.user).to eq(user) }
      end
    end

    context "when given invalid credentials" do
      context 'with wrong email' do
        let(:email) { 'wrongemail@example.com' }

        it { is_expected.to be false }

        context 'instance' do
          before { subject }

          it { expect(instance.user).to be_nil }
        end
      end

      context 'with wrong password' do
        let(:password) { 'wrongpassword' }

        it { is_expected.to be false }

        context 'instance' do
          before { subject }

          it { expect(instance.user).to be_nil }
        end
      end

      context 'with wrong email and password' do
        let(:email) { 'wrongemail@example.com' }
        let(:password) { 'wrongpassword' }

        it { is_expected.to be false }

        context 'instance' do
          before { subject }

          it { expect(instance.user).to be_nil }
        end
      end
    end
  end
end
