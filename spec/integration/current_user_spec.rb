# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Current User" do
  include_examples 'query is successful', :currentUser do
    let(:user) { create(:user_with_addresses) }
    let(:address_nodes) { subject.dig(:data, :currentUser, :addresses, :nodes) }
    let(:default_address) { subject.dig(:data, :currentUser, :defaultAddress) }
    let(:ship_address) { subject.dig(:data, :currentUser, :shipAddress) }
    let(:bill_address) { subject.dig(:data, :currentUser, :billAddress) }
    let(:context) { Hash[current_user: user] }

    it { expect(subject.dig(:data, :currentUser)).to be_present }

    it { expect(address_nodes).to be_present }
    it { expect(default_address).to be_present }
    it { expect(ship_address).to be_present }
    it { expect(bill_address).to be_present }
  end
end
