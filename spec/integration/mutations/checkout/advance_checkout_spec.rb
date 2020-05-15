# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :advance_checkout, mutation: :advance_checkout do
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
    it { expect(subject[:data][:advanceCheckout]).to be_nil }
    it { expect(subject[:errors].first[:message]).to eq I18n.t(:"unauthorized.default") }
  end

  context "when current order isn't present" do
    let(:current_order) { nil }

    include_examples "responds with an unauthorized error"
  end

  context "when current order is valid" do
    let(:current_order) { create(:order_with_line_items) }
    let(:user_errors) { subject[:data][:advanceCheckout][:errors] }

    context 'and the current ability is unauthorized' do
      include_examples "responds with an unauthorized error"
    end

    context 'and the current ability is authorized' do
      let(:guest_token) { current_order.guest_token }
      let(:response_order) { subject[:data][:advanceCheckout][:order] }
      let(:confirm_state) { 'confirm' }
      let(:address_state) { 'address' }

      shared_examples "responds with the current order in confirm state" do
        it { expect(response_order[:number]).to eq(current_order.number) }
        it { expect(response_order[:email]).to eq(current_order.email) }
        it { expect(response_order[:state]).to eq(confirm_state) }
        it { expect(user_errors.first[:path]).to eq(["input", "order", "state"]) }
        it { expect(user_errors.first[:message]).to eq("cannot transition via \"next\"") }
        it { is_expected.to_not have_key(:errors) }
      end

      context 'when current order state' do
        describe 'is cart' do
          include_examples "responds with the current order in confirm state"
        end

        describe 'is address' do
          before { current_order.update(state: address_state) }

          include_examples "responds with the current order in confirm state"
        end
      end

      context "and the given current order state cannot advance" do
        before { current_order.update(state: confirm_state) }

        include_examples "responds with the current order in confirm state"
      end
    end
  end
end
