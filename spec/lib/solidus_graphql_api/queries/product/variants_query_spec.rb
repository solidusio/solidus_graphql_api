# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Product::VariantsQuery do
  let(:product) { create(:product) }

  let!(:variants) { create_list(:variant, 2, product: product) }

  it { expect(described_class.new(product: product).call.sync).to match_array(variants) }
end
