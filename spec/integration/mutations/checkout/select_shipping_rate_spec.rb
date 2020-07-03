# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :select_shipping_rate, mutation: :select_shipping_rate do
  let(:current_ability) { Spree::Ability.new(nil) }
  let(:guest_token) { nil }
  let(:mutation_context) {
    Hash[
      current_ability: current_ability,
      current_order: current_order,
      order_token: guest_token
    ]
  }

  let(:shipping_rate_id) { 'U3ByZWU6OlNoaXBwaW5nUmF0ZS0xMDAw' }
  let(:mutation_variables) {
    Hash[
      input: {
        shippingRateId: shipping_rate_id
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
    let(:current_order) { create(:completed_order_with_totals) }

    include_examples "responds with an unauthorized error"
  end

  context "when current order isn't completed" do
    let(:current_order) { create(:order_with_line_items) }
    let(:shipping_rate) { create(:shipping_rate, cost: 20) }
    let(:user_errors) { subject[:data][:selectShippingRate][:errors] }

    before do
      current_order.shipments.first.shipping_rates << shipping_rate
    end

    context 'and the current ability is unauthorized' do
      include_examples "responds with an unauthorized error"
    end

    context 'and the current ability is authorized' do
      let(:guest_token) { current_order.guest_token }
      let(:response_order) { subject[:data][:selectShippingRate][:order] }

      context "when the given shipping rate id is wrong" do
        it { expect(subject[:data][:selectShippingRate]).to be_nil }
        it { expect(subject[:errors].first[:message]).to eq I18n.t(:'activerecord.exceptions.not_found') }
      end

      context "when there are errors during shipping rate selection" do
        let(:selected_shipping_rate_id) { SolidusGraphqlApi::Schema.id_from_object(shipping_rate, nil, nil) }
        let(:shipping_rate_id) { selected_shipping_rate_id }

        before do
          order_updater = instance_double('Spree::OrderUpdateAttributes', apply: false)
          allow(Spree::OrderUpdateAttributes).to receive(:new).and_return(order_updater)
        end

        it { expect(subject[:data][:selectShippingRate]).to have_key(:errors) }
      end

      context "when the given shipping rate id is correct" do
        let(:selected_shipping_rate_id) { SolidusGraphqlApi::Schema.id_from_object(shipping_rate, nil, nil) }
        let(:shipping_rate_id) { selected_shipping_rate_id }

        it "selects the correct shipping rate" do
          shipping_rates = response_order[:shipments][:nodes].first[:shippingRates][:nodes]
          selected_shipping_rate = shipping_rates.find { |shipping_rate| shipping_rate[:selected] }

          expect( selected_shipping_rate[:id]).to eq(shipping_rate.id)
        end
      end
    end
  end
end
