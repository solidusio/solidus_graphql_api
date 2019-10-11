# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Types::Taxon do
  let(:taxon) { double(:taxon) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, taxon, {}) }

  describe '#children' do
    before { allow(Spree::Queries::Taxon::ChildrenQuery).to receive(:new).and_return(query_object) }

    after { subject.children }

    it { expect(Spree::Queries::Taxon::ChildrenQuery).to receive(:new).with(taxon: taxon) }

    it { expect(query_object).to receive(:call) }
  end

  describe '#parent_taxon' do
    before { allow(Spree::Queries::Taxon::ParentTaxonQuery).to receive(:new).and_return(query_object) }

    after { subject.parent_taxon }

    it { expect(Spree::Queries::Taxon::ParentTaxonQuery).to receive(:new).with(taxon: taxon) }

    it { expect(query_object).to receive(:call) }
  end
end
