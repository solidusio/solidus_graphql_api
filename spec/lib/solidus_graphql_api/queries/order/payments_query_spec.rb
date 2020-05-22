# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Order::PaymentsQuery do
  let(:order) { create :completed_order_with_pending_payment }

  it { expect(described_class.new(order: order).call.sync).to eq order.payments }
end
