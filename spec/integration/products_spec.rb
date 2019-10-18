# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Products" do
  include_examples 'query is successful', :products do
    let(:product_nodes) { subject.data.products.nodes }
    let(:master_variant_nodes) { product_nodes.map(&:masterVariant) }
    let(:master_variant_images_nodes) { master_variant_nodes.map(&:images) }
    let(:option_type_nodes) { product_nodes.map { |product_node| product_node.optionTypes.nodes }.flatten }
    let(:option_value_nodes) { option_type_nodes.map { |option_type| option_type.optionValues.nodes }.flatten }
    let(:product_properties_nodes) { product_nodes.map { |product_node| product_node.productProperties.nodes }.flatten }
    let(:product_properties_property_nodes) { product_properties_nodes.map(&:property) }
    let(:variant_nodes) { product_nodes.map { |product_node| product_node.variants.nodes }.flatten }
    let(:variant_default_price_nodes) { variant_nodes.map(&:defaultPrice) }
    let(:variant_option_value_nodes) { variant_nodes.map { |variant_node| variant_node.optionValues.nodes }.flatten }
    let(:variant_price_nodes) { variant_nodes.map { |variant_node| variant_node.prices.nodes }.flatten }

    let(:product) { create(:product_with_option_types) }

    before do
      product.option_types.each do |option_type|
        create(:option_value, option_type: option_type)
      end
      create_list(:variant, 2, product: product)
      create(:product_property, product: product)
    end

    it { expect(product_nodes).to be_present }

    it { expect(master_variant_nodes).to be_present }

    it { expect(master_variant_images_nodes).to be_present }

    it { expect(option_type_nodes).to be_present }

    it { expect(option_value_nodes).to be_present }

    it { expect(product_properties_nodes).to be_present }

    it { expect(product_properties_property_nodes).to be_present }

    it { expect(variant_nodes).to be_present }

    it { expect(variant_default_price_nodes).to be_present }

    it { expect(variant_option_value_nodes).to be_present }

    it { expect(variant_price_nodes).to be_present }
  end
end
