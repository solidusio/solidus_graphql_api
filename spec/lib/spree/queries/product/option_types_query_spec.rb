# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Queries::Product::OptionTypesQuery do
  let(:product) { create(:product) }

  let!(:option_types) { create_list(:option_type, 2, products: [product]) }

  it { expect(described_class.new(product: product).call.sync).to eq(option_types) }
end
