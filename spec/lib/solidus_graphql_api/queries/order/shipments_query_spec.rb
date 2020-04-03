# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Order::ShipmentsQuery do
  let(:order) { create :order }
  let(:shipment) { create(:shipment) }

  context 'when order has shipments' do
    before { order.shipments << shipment }

    it { expect(described_class.new(order: order).call.sync).to eq [shipment] }
  end

  context 'when order does not have shipments' do
    it { expect(described_class.new(order: order).call.sync).to be_empty }
  end
end
