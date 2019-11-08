# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Address::StateQuery do
  subject { described_class.new(address: address).call.sync }

  let(:address) { create(:address) }

  let(:state) { address.state }

  it { is_expected.to eq(state) }
end
