# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Taxonomies" do
  include_examples 'query is successful', :taxonomies do
    let(:taxonomy_nodes) { subject.data.taxonomies.nodes }
    let(:taxon_nodes) { taxonomy_nodes.map { |taxonomy_node| taxonomy_node.taxons.nodes }.flatten }
    let(:child_nodes) { taxon_nodes.map { |taxon_node| taxon_node.children.nodes }.flatten }

    before do
      taxonomies = create_list(:taxonomy, 2)
      taxonomies.each do |taxonomy|
        create(:taxon, taxonomy: taxonomy, parent: taxonomy.taxons.first)
      end
    end

    it { expect(taxonomy_nodes).to be_present }

    it { expect(taxon_nodes).to be_present }

    it { expect(child_nodes).to be_present }
  end
end
