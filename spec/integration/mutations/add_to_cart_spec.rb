# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :add_to_cart, mutation: :add_to_cart do
  let(:current_ability) { Spree::Ability.new(nil) }
  let(:guest_token) { nil }
  let(:mutation_context) {
    Hash[
      current_ability: current_ability,
      current_order: current_order,
      order_token: guest_token
    ]
  }

  let(:variant) { create(:variant) }
  let(:variant_id) {
    SolidusGraphqlApi::Schema.id_from_object(variant, nil, nil)
  }
  let(:quantity) { 10 }
  let(:mutation_variables) {
    Hash[
      input: {
        variantId: variant_id,
        quantity: quantity
      }
    ]
  }

  shared_examples "responds with an unauthorized error" do
    it { expect(subject[:data][:addToCart]).to be_nil }
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
    let(:current_order) { create(:order, state: 'payment') }
    let(:user_errors) { subject[:data][:addToCart][:errors] }

    context 'and the current ability is unauthorized' do
      include_examples "responds with an unauthorized error"
    end

    context 'and the current ability is authorized' do
      let(:guest_token) { current_order.guest_token }
      let(:response_order) { subject[:data][:addToCart][:order] }

      it { expect(response_order[:number]).to eq(current_order.number) }
      it { expect(response_order[:state]).to eq('address') }
      it { expect(response_order[:lineItems][:nodes].first[:quantity]).to eq(10) }
      it { expect(response_order[:lineItems][:nodes].first[:variant][:id]).to eq(variant.id) }
      it { expect(user_errors).to be_empty }
      it { is_expected.to_not have_key(:errors) }
    end
  end
end
