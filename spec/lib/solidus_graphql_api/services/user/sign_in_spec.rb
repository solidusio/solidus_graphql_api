# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Services::User::SignIn do
  let(:email) { "john@example.com" }
  let(:password) { "secret" }

  subject(:instance) { described_class.new }

  describe "#call" do
    subject { instance.call(email: email, password: password) }

    context "when given valid credentials" do
      let!(:user) { create(:user, email: email, password: password) }

      it { is_expected.to be true }

      context 'instance' do
        before { subject }

        it { expect(instance.user).to eq(user) }
      end
    end

    context "when given invalid credentials" do
      it { is_expected.to be false }

      context 'instance' do
        before { subject }

        it { expect(instance.user).to be_nil }
      end
    end
  end
end
