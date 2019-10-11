# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Products" do
  include_examples 'query is successful', :products do
    let(:product_nodes) { subject.data.products.nodes }
    let(:master_variant_nodes) { product_nodes.map(&:masterVariant) }
    let(:variant_nodes) { product_nodes.map { |product_node| product_node.variants.nodes }.flatten }
    let(:variant_default_price_nodes) { variant_nodes.map(&:defaultPrice) }
    let(:variant_option_value_nodes) { variant_nodes.map { |variant_node| variant_node.optionValues.nodes }.flatten }
    let(:variant_price_nodes) { variant_nodes.map { |variant_node| variant_node.prices.nodes }.flatten }

    before do
      create_list(:variant, 2)
    end

    it { expect(product_nodes).to be_present }

    it { expect(master_variant_nodes).to be_present }

    it { expect(variant_nodes).to be_present }

    it { expect(variant_default_price_nodes).to be_present }

    it { expect(variant_option_value_nodes).to be_present }

    it { expect(variant_price_nodes).to be_present }
  end
end
