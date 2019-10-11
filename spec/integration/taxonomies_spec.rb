# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Taxonomies" do
  include_examples 'query is successful', :taxonomies do
    let(:taxonomy_nodes) { subject.data.taxonomies.nodes }
    let(:root_taxon_nodes) { taxonomy_nodes.map(&:rootTaxon) }
    let(:taxon_nodes) { taxonomy_nodes.map { |taxonomy_node| taxonomy_node.taxons.nodes }.flatten }
    let(:child_nodes) { taxon_nodes.map { |taxon_node| taxon_node.children.nodes }.flatten }
    let(:parent_taxon_nodes) { child_nodes.map(&:parentTaxon) }

    before do
      taxonomies = create_list(:taxonomy, 2)
      taxonomies.each do |taxonomy|
        create(:taxon, taxonomy: taxonomy, parent: taxonomy.taxons.first)
      end
    end

    it { expect(taxonomy_nodes).to be_present }

    it { expect(taxon_nodes).to be_present }

    it { expect(child_nodes).to be_present }

    it { expect(root_taxon_nodes).to be_present }

    it { expect(parent_taxon_nodes).to be_present }
  end
end
