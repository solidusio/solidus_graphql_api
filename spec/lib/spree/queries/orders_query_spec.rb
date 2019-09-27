# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Queries::OrdersQuery do
  let(:user) { create(:user) }
  let(:completed_orders) { create_list(:completed_order_with_totals, 2, user: user) }

  it { expect(described_class.new(user: user).call).to eq(completed_orders) }
end
