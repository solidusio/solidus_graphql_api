# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Order::BillingAddressQuery do
  let(:order) { create :order, bill_address: billing_address }

  let(:billing_address) { create :bill_address }

  it { expect(described_class.new(order: order).call.sync).to eq billing_address }
end
