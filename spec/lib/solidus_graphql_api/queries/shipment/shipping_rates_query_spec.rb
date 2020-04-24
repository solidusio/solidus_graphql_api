# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Shipment::ShippingRatesQuery do
  let(:shipment) { create(:shipment, shipping_rates: []) }
  let(:shipping_rates) { shipment.shipping_rates }

  context 'when shipment has shipping_rates' do
    it { expect(described_class.new(shipment: shipment).call.sync).to eq shipping_rates }
  end

  context 'when shipment does not have shipping_rates' do
    before { shipment.shipping_rates.destroy_all }

    it { expect(described_class.new(shipment: shipment).call.sync).to be_empty }
  end
end
