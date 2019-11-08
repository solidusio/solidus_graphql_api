# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::Variant do
  let(:variant) { create(:variant) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, variant, {}) }

  describe '#default_price' do
    before do
      allow(SolidusGraphqlApi::Queries::Variant::DefaultPriceQuery).to receive(:new).and_return(query_object)
    end

    after { subject.default_price }

    it { expect(SolidusGraphqlApi::Queries::Variant::DefaultPriceQuery).to receive(:new).with(variant: variant) }

    it { expect(query_object).to receive(:call) }
  end

  describe '#option_values' do
    before do
      allow(SolidusGraphqlApi::Queries::Variant::OptionValuesQuery).to receive(:new).and_return(query_object)
    end

    after { subject.option_values }

    it { expect(SolidusGraphqlApi::Queries::Variant::OptionValuesQuery).to receive(:new).with(variant: variant) }

    it { expect(query_object).to receive(:call) }
  end

  describe '#prices' do
    before do
      allow(SolidusGraphqlApi::Queries::Variant::PricesQuery).to receive(:new).and_return(query_object)
    end

    after { subject.prices }

    it { expect(SolidusGraphqlApi::Queries::Variant::PricesQuery).to receive(:new).with(variant: variant) }

    it { expect(query_object).to receive(:call) }
  end
end
