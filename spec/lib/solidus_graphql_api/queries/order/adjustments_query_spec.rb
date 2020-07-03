# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Order::AdjustmentsQuery do
  let(:promotion) { create :promotion_with_order_adjustment }
  let(:order) { create :completed_order_with_promotion, promotion: promotion }

  it { expect(described_class.new(order: order).call.sync).to eq order.adjustments }
end
