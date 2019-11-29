# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Variant::PricesQuery do
  let(:variant) { create(:variant) }

  let(:prices) { create_list(:price, 2, variant: variant) }

  let!(:variant_prices) { [variant.default_price] + prices }

  it { expect(described_class.new(variant: variant).call.sync).to match_array(variant_prices) }
end
