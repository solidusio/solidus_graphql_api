# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :currentOrder, query: :current_order, freeze_date: true do
  let!(:order) { create :order_with_line_items, id: 1, number: 'fake number' }

  let(:query_context) { { current_order: order } }
  let(:shipment_number) { order.shipments.first.number }

  field :currentOrder do
    it { is_expected.to match_response(:current_order).with_args(shipment_number: shipment_number) }
  end
end
