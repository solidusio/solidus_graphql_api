# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :update_cart_quantity, mutation: :update_cart_quantity do
  let(:current_ability) { Spree::Ability.new(nil) }
  let(:guest_token) { nil }
  let(:mutation_context) {
    Hash[
      current_ability: current_ability,
      current_order: current_order,
      order_token: guest_token
    ]
  }

  let(:line_item) { current_order.line_items.first }
  let(:line_item_id) {
    SolidusGraphqlApi::Schema.id_from_object(line_item, nil, nil)
  }
  let(:quantity) { 10 }
  let(:mutation_variables) {
    Hash[
      input: {
        lineItemId: line_item_id,
        quantity: quantity
      }
    ]
  }

  shared_examples "responds with an unauthorized error" do
    it { expect(subject[:data][:updateCartQuantity]).to be_nil }
    it { expect(subject[:errors].first[:message]).to eq I18n.t(:"unauthorized.default") }
  end

  context "when current order isn't present" do
    let(:current_order) { nil }
    let(:line_item_id) { 'not_existent' }

    include_examples "responds with an unauthorized error"
  end

  context "when current order is completed" do
    let(:current_order) { create(:completed_order_with_totals) }

    include_examples "responds with an unauthorized error"
  end

  context "when current order isn't completed" do
    let(:current_order) { create(:order_with_line_items, state: 'delivery') }
    let(:user_errors) { subject[:data][:updateCartQuantity][:errors] }

    context 'and the current ability is unauthorized' do
      include_examples "responds with an unauthorized error"
    end

    context 'and the current ability is authorized' do
      let(:guest_token) { current_order.guest_token }
      let(:response_order) { subject[:data][:updateCartQuantity][:order] }

      it { expect(response_order[:number]).to eq(current_order.number) }
      it { expect(response_order[:state]).to eq('address') }
      it { expect(response_order[:lineItems][:nodes].first[:id]).to eq(line_item.id) }
      it { expect(response_order[:lineItems][:nodes].first[:quantity]).to eq(10) }
      it { expect(user_errors).to be_empty }
      it { is_expected.to_not have_key(:errors) }
    end
  end
end
