# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Address::CountryQuery do
  subject { described_class.new(address: address).call.sync }

  let(:address) { create(:address) }

  let(:country) { address.country }

  it { is_expected.to eq(country) }
end
