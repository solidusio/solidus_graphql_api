# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Context do
  let(:schema_context) { described_class.new(request: request) }

  let(:headers) do
    headers_hash = {}
    headers_hash['Authorization'] = "Bearer #{authorization_token}" if defined?(authorization_token) && authorization_token
    headers_hash
  end

  let(:request) { ActionDispatch::TestRequest.create.tap { |request| request.headers.merge!(headers) } }

  describe '#to_h' do
    subject { schema_context.to_h }

    let(:current_user) { Spree::User.new }
    let(:current_ability) { Spree::Ability.new(nil) }

    before do
      allow(schema_context).to receive(:current_user).and_return(current_user)
      allow(schema_context).to receive(:current_ability).and_return(current_ability)
    end

    it { is_expected.to be_an(Hash) }

    it { is_expected.to have_key(:current_user) }
    it { expect(subject[:current_user]).to eq current_user }

    it { is_expected.to have_key(:current_ability) }
    it { expect(subject[:current_ability]).to eq current_ability }
  end

  describe '#current_user' do
    subject { schema_context.current_user }

    context 'when headers do not contains the authorization token' do
      it { is_expected.to be_nil }
    end

    context 'when headers contains the authorization token' do
      let!(:user) { create(:user).tap(&:generate_spree_api_key!) }

      context 'and the authorization token is invalid' do
        let(:authorization_token) { 'wrongauthorizationtoken' }

        it { is_expected.to be_nil }
      end

      context 'and the authorization token is valid' do
        let(:authorization_token) { user.spree_api_key }

        it { is_expected.to eq user }
      end
    end
  end

  describe '#current_ability' do
    subject { schema_context.current_ability }

    after { subject }

    context 'when headers do not contains the authorization token' do
      it { is_expected.to be_a Spree::Ability }
      it { expect(Spree::Ability).to receive(:new).with(nil) }
    end

    context 'when headers contains the authorization token' do
      let!(:user) { create(:user).tap(&:generate_spree_api_key!) }

      context 'and the authorization token is invalid' do
        let(:authorization_token) { 'wrongauthorizationtoken' }

        it { is_expected.to be_a Spree::Ability }
        it { expect(Spree::Ability).to receive(:new).with(nil) }
      end

      context 'and the authorization token is valid' do
        let(:authorization_token) { user.spree_api_key }

        it { is_expected.to be_a Spree::Ability }
        it { expect(Spree::Ability).to receive(:new).with(user) }
      end
    end
  end
end
