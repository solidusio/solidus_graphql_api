# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Product::ProductPropertiesQuery do
  let(:product) { create(:product) }

  let!(:product_properties) { create_list(:product_property, 2, product: product) }

  it { expect(described_class.new(product: product).call.sync).to match_array(product_properties) }
end
