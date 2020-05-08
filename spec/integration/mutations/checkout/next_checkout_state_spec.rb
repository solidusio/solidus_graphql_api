# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :next_checkout_state, mutation: :next_checkout_state do
  let(:current_ability) { Spree::Ability.new(nil) }
  let(:guest_token) { nil }
  let(:mutation_context) {
    Hash[
      current_ability: current_ability,
      current_order: current_order,
      order_token: guest_token
    ]
  }

  let(:mutation_variables) { Hash[input: {}] }

  shared_examples "responds with an unauthorized error" do
    it { expect(subject[:data][:nextCheckoutState]).to be_nil }
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
    let(:current_order) { create(:order_with_line_items) }
    let(:user_errors) { subject[:data][:nextCheckoutState][:errors] }

    context 'and the current ability is unauthorized' do
      include_examples "responds with an unauthorized error"
    end

    context 'and the current ability is authorized' do
      let(:guest_token) { current_order.guest_token }
      let(:response_order) { subject[:data][:nextCheckoutState][:order] }

      context 'and the given current order state can advance' do
        it { expect(response_order[:number]).to eq(current_order.number) }
        it { expect(response_order[:email]).to eq(current_order.email) }
        it { expect(response_order[:state]).to eq('address') }
        it { expect(user_errors).to be_empty }
        it { is_expected.to_not have_key(:errors) }
      end

      context "and the given current order state cannot advance" do
        let(:confirm_state) { 'confirm' }

        before { current_order.update(state: confirm_state) }

        it { expect(response_order[:number]).to eq(current_order.number) }
        it { expect(response_order[:email]).to eq(current_order.email) }
        it { expect(response_order[:state]).to eq(confirm_state) }
        it { expect(user_errors.first[:path]).to eq(["input", "order", "state"]) }
        it { expect(user_errors.first[:message]).to eq("cannot transition via \"next\"") }
        it { is_expected.to_not have_key(:errors) }
      end
    end
  end
end
