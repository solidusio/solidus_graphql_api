# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :product_by_slug, query: :product_by_slug, freeze_date: true do
  let!(:product) { create(:product, id: 1, name: 'Product', slug: 'slug', sku: 'SKU') }

  let!(:option_type) { create(:option_type, id: 1, name: 'foo-size') }
  let!(:option_value) { create(:option_value, id: 1, name: 'Size', option_type: option_type) }
  let!(:product_option_type) { create(:product_option_type, id: 1, product: product, option_type: option_type) }

  let!(:product_property) { create(:product_property, id: 1, product: product) }

  let!(:first_variant) { create(:base_variant, product: product) }
  let!(:second_variant) { create(:base_variant, product: product) }

  before do
    product.master.update!(option_values: [option_value])
  end

  field :productBySlug do
    context "when the slug doesn't exist" do
      let(:query_variables) { { slug: 'non-existent-slug' } }

      it { expect(subject.dig(:data, :productBySlug)).to be_nil }
    end

    context 'when the slug exists' do
      let(:query_variables) { { slug: 'slug' } }

      let(:args) do
        {
          product: product,
          first_variant: first_variant,
          second_variant: second_variant
        }
      end

      it { is_expected.to match_response(:product_by_slug).with_args(args) }
    end
  end
end
