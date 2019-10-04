# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Types::Variant do
  let(:variant) { create(:variant) }

  subject { described_class.send(:new, variant, {}) }

  describe '#prices' do
    let(:query_object) { spy(:query_object) }

    before do
      allow(Spree::Queries::Variant::PricesQuery).to receive(:new).and_return(query_object)
    end

    after { subject.prices }

    it { expect(Spree::Queries::Variant::PricesQuery).to receive(:new).with(variant: variant) }

    it { expect(query_object).to receive(:call) }
  end
end
