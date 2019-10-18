# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Types::Query do
  subject { described_class.send(:new, {}, {}) }

  it { expect(described_class.method_defined?(:countries)).to be_truthy }
  it { expect(described_class.method_defined?(:taxonomies)).to be_truthy }

  describe '#products' do
    let(:query_object) { spy(:query_object) }

    before { allow(Spree::Queries::ProductsQuery).to receive(:new).and_return(query_object) }

    after { subject.products }

    it { expect(Spree::Queries::ProductsQuery).to receive(:new) }

    it { expect(query_object).to receive(:call) }
  end
end
