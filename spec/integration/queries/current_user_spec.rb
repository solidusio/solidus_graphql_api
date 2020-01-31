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

  field :currentUser do
    context 'when context does not have current user' do
      it { expect(subject.dig(:data, :currentUser)).to be_nil }
    end

    context 'when context have current user' do
      let!(:query_context) { Hash[current_user: user] }

      it { is_expected.to match_response(:current_user) }
    end
  end
end
