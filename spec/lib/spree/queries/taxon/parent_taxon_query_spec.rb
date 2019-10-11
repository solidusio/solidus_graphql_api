# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Queries::Taxon::ParentTaxonQuery do
  let(:parent_taxon) { create(:taxon) }
  let(:taxon) { create(:taxon, parent: parent_taxon) }

  it { expect(described_class.new(taxon: taxon).call.sync).to eq(parent_taxon) }
end
