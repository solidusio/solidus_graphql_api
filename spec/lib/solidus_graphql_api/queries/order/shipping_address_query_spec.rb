# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Order::ShippingAddressQuery do
  let(:order) { create :order, ship_address: shipping_address }

  let(:shipping_address) { create :ship_address }

  it { expect(described_class.new(order: order).call.sync).to eq shipping_address }
end
