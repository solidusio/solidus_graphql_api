# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Orders" do

  include_examples 'query is successful', :orders do
    let(:current_user) { create(:user) }
    let(:context1) do
      { current_user: current_user }
    end
    let(:order_nodes) { subject.data.orders.nodes }

    before do
      create_list(:order, 2)
    end

    it { expect(order_nodes).to be_present }
  end
end
