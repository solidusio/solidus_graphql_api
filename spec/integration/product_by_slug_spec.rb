# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "ProductBySlug" do
  include_examples 'query is successful', :product_by_slug do
    let!(:product) { create(:product) }
    let(:variables) { Hash[slug: product.slug] }

    let(:product_id) { SolidusGraphqlApi::Schema.id_from_object(product, Spree::Product, {}) }

    it { expect(subject.data.productBySlug.id).to eq product_id }
  end
end
