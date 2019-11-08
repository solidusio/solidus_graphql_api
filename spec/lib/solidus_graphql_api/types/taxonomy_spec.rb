# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::Taxonomy do
  let(:taxonomy) { double(:taxonomy) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, taxonomy, {}) }

  describe '#taxons' do
    before { allow(SolidusGraphqlApi::Queries::Taxonomy::TaxonsQuery).to receive(:new).and_return(query_object) }

    after { subject.taxons }

    it { expect(SolidusGraphqlApi::Queries::Taxonomy::TaxonsQuery).to receive(:new).with(taxonomy: taxonomy) }

    it { expect(query_object).to receive(:call) }
  end

  describe '#root_taxon' do
    before { allow(SolidusGraphqlApi::Queries::Taxonomy::RootTaxonQuery).to receive(:new).and_return(query_object) }

    after { subject.root_taxon }

    it { expect(SolidusGraphqlApi::Queries::Taxonomy::RootTaxonQuery).to receive(:new).with(taxonomy: taxonomy) }

    it { expect(query_object).to receive(:call) }
  end
end
