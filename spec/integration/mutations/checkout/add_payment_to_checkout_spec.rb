# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :add_payment_to_checkout, mutation: :add_payment_to_checkout do
  let(:current_ability) { Spree::Ability.new(nil) }
  let(:guest_token) { nil }
  let(:mutation_context) {
    Hash[
      current_ability: current_ability,
      current_order: current_order,
      order_token: guest_token
    ]
  }

  let(:payment_method_id) { "U3ByZWU6OlBheW1lbnRNZXRob2QtMTAwMg==" }
  let(:amount) { 10 }
  let(:source) { Hash[] }
  let(:mutation_variables) {
    Hash[
      input: {
        paymentMethodId: payment_method_id,
        amount: amount,
        source: source
      }
    ]
  }

  shared_examples "responds with an unauthorized error" do
    it { expect(subject[:data][:selectShippingRate]).to be_nil }
    it { expect(subject[:errors].first[:message]).to eq I18n.t(:"unauthorized.default") }
  end

  context "when current order isn't present" do
    let(:current_order) { nil }

    include_examples "responds with an unauthorized error"
  end

  context "when current order is completed" do
    let(:current_order) { create(:order_with_line_items) }

    include_examples "responds with an unauthorized error"
  end

  context "when current order isn't completed" do
    let(:current_order) { create(:order_with_line_items) }
    let(:user_errors) { subject[:data][:addPaymentToCheckout][:errors] }
    let!(:payment_method) { create(:check_payment_method) }

    context 'and the current ability is unauthorized' do
      include_examples "responds with an unauthorized error"
    end

    context 'and the current ability is authorized' do
      let(:guest_token) { current_order.guest_token }
      let(:response_order) { subject[:data][:addPaymentToCheckout][:order] }

      context "when the given payment method id is wrong" do
        it { expect(subject[:data][:addPaymentToCheckout]).to be_nil }
        it { expect(subject[:errors].first[:message]).to eq I18n.t(:'activerecord.exceptions.not_found') }
      end

      context "when the given payment method id is correct" do
        let(:payment_method_id) { SolidusGraphqlApi::Schema.id_from_object(payment_method, nil, nil) }

        it "add a payment source to the order" do
          aggregate_failures do
            expect(response_order[:number]).to eq(current_order.number)
            expect(user_errors).to be_empty
          end
        end
      end
    end
  end
end
