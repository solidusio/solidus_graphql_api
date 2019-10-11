# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Queries::Taxonomy::RootTaxonQuery do
  let(:taxonomy) { create(:taxonomy) }
  let(:root_taxon) { taxonomy.root }

  it { expect(described_class.new(taxonomy: taxonomy).call.sync).to eq(root_taxon) }
end
