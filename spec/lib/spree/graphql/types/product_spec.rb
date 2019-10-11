# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Types::Product do
  let(:product) { create(:product) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, product, {}) }

  describe '#variants' do
    before do
      allow(Spree::Queries::Product::VariantsQuery).to receive(:new).and_return(query_object)
    end

    after { subject.variants }

    it { expect(Spree::Queries::Product::VariantsQuery).to receive(:new).with(product: product) }

    it { expect(query_object).to receive(:call) }
  end
end
