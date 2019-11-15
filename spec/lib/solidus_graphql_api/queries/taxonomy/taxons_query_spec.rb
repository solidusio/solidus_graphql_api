# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Taxonomy::TaxonsQuery do
  let(:taxons) { build_list(:taxon, 2) }

  let(:taxonomy) { create(:taxonomy, taxons: taxons) }

  it { expect(described_class.new(taxonomy: taxonomy).call.sync).to match_array(taxons) }
end
