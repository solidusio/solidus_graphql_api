# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "productBySlug" do
  subject { execute_query(:product_by_slug, variables: variables) }

  let!(:product) { create(:product) }
  let(:variables) { Hash[slug: slug] }

  context 'when requested product does not exists' do
    let(:slug) { 'wrongslug' }

    it { expect(subject.data.productBySlug).to be_nil }
  end

  context 'when requested product exists' do
    let(:slug) { product.slug }

    it { expect(subject.data.productBySlug.id).to eq product.id }
  end
end
