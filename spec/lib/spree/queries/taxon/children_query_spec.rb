# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Queries::Taxon::ChildrenQuery do
  let(:taxon) { create(:taxon) }

  let!(:children) { create_list(:taxon, 2, parent: taxon) }

  it { expect(described_class.new(taxon: taxon).call.sync).to eq(children) }
end
