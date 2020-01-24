# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :taxonomies do
  connection_field :taxonomies, query: :taxonomies, freeze_date: true do
    context 'when taxonomies does not exists' do
      it { expect(subject.data.taxonomies.nodes).to be_empty }
    end

    context 'when taxonomies exists' do
      let!(:brand_taxonomy) { create(:taxonomy, :with_taxon_meta, id: 1, root_taxon_id: 1) }
      let!(:category_taxonomy) { create(:taxonomy, id: 2, name: 'Category', root_taxon_id: 2) }

      before do
        create(:taxon, id: 3, name: 'Solidus', parent: brand_taxonomy.root, taxonomy: brand_taxonomy)
      end

      it { is_expected.to match_response(:taxonomies) }
    end
  end
end
