# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Taxonomy::TaxonsQuery do
  it do
    taxonomy = create(:taxonomy)
    root_taxon = taxonomy.root
    taxon = create(:taxon, taxonomy: taxonomy, parent: root_taxon)
    create(:taxon)

    expect(described_class.new(taxonomy: taxonomy).call.sync).to match_array([root_taxon, taxon])
  end
end
