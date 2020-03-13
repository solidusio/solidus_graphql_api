# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :current_user, query: :current_user, freeze_date: true do
  let(:user) {
    create(:user,
           id: 1,
           email: 'email@example.com',
           spree_api_key: '123',
           ship_address: ship_address,
           bill_address: bill_address)
  }

  let(:ship_address) { create(:ship_address, id: 1, zipcode: 10_001) }
  let(:bill_address) { create(:bill_address, id: 2, zipcode: 10_002) }
  let(:credit_card) {
    create(:credit_card,
           user: user,
           cc_type: 'visa',
           address: ship_address,
           payment_method: create(:payment_method, id: 1))
  }

  before do
    wallet_payment_source = user.wallet.add credit_card
    wallet_payment_source.update!(default: true)
  end

  field :currentUser do
    context 'when context does not have current user' do
      it { expect(subject.dig(:data, :currentUser)).to be_nil }
    end

    context 'when context have current user' do
      let!(:query_context) { Hash[current_user: user] }

      let(:args) { { wallet: user.wallet } }

      it { is_expected.to match_response(:current_user).with_args(args) }
    end
  end
end
