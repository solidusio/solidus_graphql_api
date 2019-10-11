# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Types::ProductProperty do
  let(:product_property) { double(:product_property) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, product_property, {}) }

  describe '#property' do
    let(:query_class) { Spree::Queries::ProductProperty::PropertyQuery }

    before { allow(query_class).to receive(:new).and_return(query_object) }

    after { subject.property }

    it { expect(query_class).to receive(:new).with(product_property: product_property) }

    it { expect(query_object).to receive(:call) }
  end
end
