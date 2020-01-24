# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::CompletedOrdersQuery do
  subject { described_class.new(user: user).call }

  let(:user) { create :user }
  let!(:orders) { create_list(:completed_order_with_totals, 2, user: user) }

  it { is_expected.to eq orders }
end
