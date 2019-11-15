# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::TaxonomiesQuery do
  subject { described_class.new.call }

  let!(:taxonomies) { create_list(:taxonomy, 2) }

  it { is_expected.to eq(taxonomies) }
end
