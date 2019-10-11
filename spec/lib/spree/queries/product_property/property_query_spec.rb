# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Queries::ProductProperty::PropertyQuery do
  let(:property) { create(:property) }

  let!(:product_property) { create(:product_property, property: property) }

  it { expect(described_class.new(product_property: product_property).call.sync).to eq(property) }
end
