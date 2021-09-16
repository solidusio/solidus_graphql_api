# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::ShippingRate::ShippingMethodQuery do
  let(:shipping_method) { create(:shipping_method) }

  let(:shipping_rate) { create(:shipping_rate, shipping_method: shipping_method) }

  it { expect(described_class.new(shipping_rate: shipping_rate).call.sync).to eq(shipping_method) }
end
