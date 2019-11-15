# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::ProductBySlugQuery do
  subject { described_class.new.call(slug: slug) }

  let!(:products) { create_list(:product, 2) }
  let(:product) { products.last }
  let(:slug) { product.slug }

  it { is_expected.to eq(product) }
end
