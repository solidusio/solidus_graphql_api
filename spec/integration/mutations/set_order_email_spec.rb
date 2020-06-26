# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :set_order_email, mutation: :set_order_email do
  let(:current_ability) { Spree::Ability.new(nil) }
  let(:guest_token) { nil }
  let(:mutation_context) {
    Hash[
      current_ability: current_ability,
      current_order: current_order,
      order_token: guest_token
    ]
  }

  let(:email) { 'test@example.com' }
  let(:mutation_variables) {
    Hash[
      input: {
        email: email
      }
    ]
  }

  shared_examples "responds with an unauthorized error" do
    it { expect(subject[:data][:setOrderEmail]).to be_nil }
    it { expect(subject[:errors].first[:message]).to eq I18n.t(:"unauthorized.default") }
  end

  context "when current order isn't present" do
    let(:current_order) { nil }

    include_examples "responds with an unauthorized error"
  end

  context "when current order is completed" do
    let(:current_order) { create(:completed_order_with_totals) }

    include_examples "responds with an unauthorized error"
  end

  context "when current order isn't completed" do
    let(:current_order) { create(:order, state: 'cart') }
    let(:user_errors) { subject[:data][:setOrderEmail][:errors] }

    context 'and the current ability is unauthorized' do
      include_examples "responds with an unauthorized error"
    end

    context 'and the current ability is authorized' do
      let(:guest_token) { current_order.guest_token }
      let(:response_order) { subject[:data][:setOrderEmail][:order] }

      it { expect(response_order[:number]).to eq(current_order.number) }
      it { expect(response_order[:state]).to eq('cart') }
      it { expect(response_order[:email]).to eq(email) }
      it { expect(user_errors).to be_empty }
      it { is_expected.to_not have_key(:errors) }
    end
  end
end
