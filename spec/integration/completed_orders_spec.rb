# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :completed_orders do
  connection_field :completed_orders, query: :completed_orders, freeze_date: true do
    let(:current_user) { create :user, email: 'email1@example.com' }
    let(:query_context) { { current_user: current_user } }

    context 'when there are not any completed orders' do
      it { expect(subject.dig(:data, :completedOrders, :nodes)).to eq [] }
    end

    context 'when there are some completed orders' do
      let(:ship_address_1_country) { create :country, id: 1 }
      let(:ship_address_1_state) { create :state, id: 1, country: ship_address_1_country }
      let(:bill_address_1_country) { create :country, id: 2 }
      let(:bill_address_1_state) { create :state, id: 2, country: bill_address_1_country }
      let(:ship_address_2_country) { create :country, id: 3 }
      let(:ship_address_2_state) { create :state, id: 3, country: ship_address_2_country }
      let(:bill_address_2_country) { create :country, id: 4 }
      let(:bill_address_2_state) { create :state, id: 4, country: bill_address_2_country }
      let(:ship_address_1) do
        create(
          :address,
          id: 1,
          zipcode: '10001',
          address1: 'A Different Road',
          country: ship_address_1_country,
          state: ship_address_1_state
        )
      end
      let(:bill_address_1) do
        create(
          :address,
          id: 2,
          zipcode: '10002',
          address1: 'PO Box 1337',
          country: bill_address_1_country,
          state: bill_address_1_state
        )
      end
      let(:ship_address_2) do
        create(
          :address,
          id: 3,
          zipcode: '10003',
          address1: 'A Different Road',
          country: ship_address_2_country,
          state: ship_address_2_state
        )
      end
      let(:bill_address_2) do
        create(
          :address,
          id: 4,
          zipcode: '10004',
          address1: 'PO Box 1337',
          country: bill_address_2_country,
          state: bill_address_2_state
        )
      end
      let(:order_1) do
        create(
          :completed_order_with_pending_payment,
          id: 1,
          user: current_user,
          guest_token: 'fake guest token 1',
          number: 'fake order number 1',
          ship_address: ship_address_1,
          bill_address: bill_address_1
        )
      end
      let(:order_2) do
        create(
          :completed_order_with_pending_payment,
          id: 2,
          user: current_user,
          guest_token: 'fake guest token 2',
          number: 'fake order number 2',
          ship_address: ship_address_2,
          bill_address: bill_address_2
        )
      end
      let!(:completed_orders) { [order_1, order_2] }

      it { is_expected.to match_response('completed_orders') }

      connection_field :shipping_address, query: 'completed_orders/shipping_address' do
        it { is_expected.to match_response('completed_orders/shipping_address') }
      end

      connection_field :billing_address, query: 'completed_orders/billing_address' do
        it { is_expected.to match_response('completed_orders/billing_address') }
      end
    end
  end
end