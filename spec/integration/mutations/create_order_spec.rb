# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :create_order, mutation: :create_order do
  let(:current_user) { create(:user) }
  let(:current_ability) { Spree::Ability.new(nil) }
  let(:current_store) { create(:store) }
  let(:mutation_context) {
    Hash[
      current_user: current_user,
      current_ability: current_ability,
      current_store: current_store
    ]
  }

  let(:mutation_variables) {
    Hash[
      input: {}
    ]
  }

  context 'when the current ability is unauthorized' do
    before do
      current_ability.cannot :create, Spree::Order
    end

    it { expect(subject[:data][:createOrder]).to be_nil }
    it { expect(subject[:errors].first[:message]).to eq I18n.t(:"unauthorized.default") }
  end

  context 'when the current ability is authorized' do
    let(:user_errors) { subject[:data][:createOrder][:errors] }
    let(:response_order) { subject[:data][:createOrder][:order] }

    context 'and the user is authenticated' do
      let(:last_incomplete_order) { current_user.last_incomplete_spree_order(store: current_store) }

      it { expect(response_order[:number]).to eq(last_incomplete_order.number) }
      it { expect(response_order[:state]).to eq('cart') }
      it { expect(user_errors).to be_empty }
      it { is_expected.to_not have_key(:errors) }
    end

    context 'and the user is guest' do
      let(:current_user) { nil }
      let(:last_incomplete_order) { Spree::Order.incomplete.where(store: current_store).last }

      it { expect(response_order[:number]).to eq(last_incomplete_order.number) }
      it { expect(response_order[:state]).to eq('cart') }
      it { expect(user_errors).to be_empty }
      it { is_expected.to_not have_key(:errors) }
    end
  end
end
