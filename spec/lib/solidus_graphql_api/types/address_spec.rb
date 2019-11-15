# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::Address do
  let(:address) { create(:address) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, address, {}) }

  describe '#country' do
    before do
      allow(SolidusGraphqlApi::Queries::Address::CountryQuery).to(
        receive(:new).with(address: address).and_return(query_object)
      )
    end

    after { subject.country }

    it { expect(query_object).to receive(:call) }
  end

  describe '#state' do
    before do
      allow(SolidusGraphqlApi::Queries::Address::StateQuery).to(
        receive(:new).with(address: address).and_return(query_object)
      )
    end

    after { subject.state }

    it { expect(query_object).to receive(:call) }
  end
end
