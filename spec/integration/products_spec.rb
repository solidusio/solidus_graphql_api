# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Products" do
  include_examples 'query is successful', :products do
    let(:product_nodes) { subject.dig(:data, :products, :nodes) }
    let(:master_variant_nodes) { product_nodes.map { |node| node[:masterVariant] } }
    let(:master_variant_images_nodes) { master_variant_nodes.map { |node| node[:images] } }
    let(:option_type_nodes) { product_nodes.map { |node| node.dig(:optionTypes, :nodes) }.flatten }
    let(:option_value_nodes) { option_type_nodes.map { |node| node.dig(:optionValues, :nodes) }.flatten }
    let(:product_properties_nodes) { product_nodes.map { |node| node.dig(:productProperties, :nodes) }.flatten }
    let(:product_properties_property_nodes) { product_properties_nodes.map { |node| node[:property] } }
    let(:variant_nodes) { product_nodes.map { |node| node.dig(:variants, :nodes) }.flatten }
    let(:variant_default_price_nodes) { variant_nodes.map { |node| node[:defaultPrice] } }
    let(:variant_option_value_nodes) { variant_nodes.map { |node| node.dig(:optionValues, :nodes) }.flatten }
    let(:variant_price_nodes) { variant_nodes.map { |variant_node| variant_node.dig(:prices, :nodes) }.flatten }

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
