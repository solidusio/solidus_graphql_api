# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Taxon::ChildrenQuery do
  it do
    taxonomy = create(:taxonomy)
    root = taxonomy.root
    children = [
      create(:taxon, name: "Taxon one", parent: root),
      create(:taxon, name: "Taxon two", parent: root)
    ]
    expect(described_class.new(taxon: root).call.sync).to match_array(children)
  end
end
