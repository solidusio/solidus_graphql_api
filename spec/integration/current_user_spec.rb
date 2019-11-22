# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Current User" do
  include_examples 'query is successful', :currentUser do
    let(:user) { create(:user_with_addresses) }
    let(:address_nodes) { subject.data.currentUser.addresses.nodes }
    let(:default_address) { subject.data.currentUser.defaultAddress }
    let(:ship_address) { subject.data.currentUser.shipAddress }
    let(:bill_address) { subject.data.currentUser.billAddress }
    let(:context) { Hash[current_user: user] }

    it { expect(subject.data.currentUser).to_not be_nil }

    it { expect(address_nodes).to be_present }
    it { expect(default_address).to be_present }
    it { expect(ship_address).to be_present }
    it { expect(bill_address).to be_present }
  end
end
