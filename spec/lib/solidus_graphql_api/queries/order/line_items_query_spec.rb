# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Order::LineItemsQuery do
  let(:order) { create :order_with_line_items, line_items_count: 2 }

  it { expect(described_class.new(order: order).call.sync).to eq order.line_items }
end
