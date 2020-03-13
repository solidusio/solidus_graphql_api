# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::ProductsQuery do
  subject do
    described_class.new(user: user, pricing_options: pricing_options).call(query: query)
  end

  let(:user) { create :user }
  let(:pricing_options) { Spree::Config.pricing_options_class.new }
  let(:query) { {} }

  context 'when products do not exist' do
    it { is_expected.to be_empty }
  end

  context 'when products exist' do
    let(:solidus_t_shirt) { create(:product, name: 'Solidus T-Shirt', id: 1, price: 19.99) }
    let(:ruby_mug) { create(:product, name: 'Ruby Mug', id: 2, price: 9.99) }
    let(:solidus_mug) { create(:product, name: 'Solidus Mug ', id: 3, price: 9.99) }
    let(:solidus_tote) { create(:product, name: 'Solidus Tote', id: 4, price: 15.99) }
    let!(:all_products) { [solidus_t_shirt, ruby_mug, solidus_mug, solidus_tote] }

    context 'when no query is passed' do
      it { is_expected.to match_array(all_products) }
    end

    context 'when a query is passed' do
      let(:taxonomy) { create(:taxonomy, name: 'Categories') }
      let(:t_shirts_taxon) { create(:taxon, name: 'T-Shirts', taxonomy: taxonomy, products: [solidus_t_shirt]) }
      let(:mugs_taxon) { create(:taxon, name: 'Mugs', taxonomy: taxonomy, products: [ruby_mug, solidus_mug]) }
      let(:totes_taxon) { create(:taxon, name: 'Totes', taxonomy: taxonomy, products: [solidus_tote]) }

      let(:search) { { price_range_any: ["Under $10.00", "$15.00 - $18.00"] } }
      let(:query) { { taxon: totes_taxon, keywords: "Solidus", search: search } }

      it { is_expected.to match_array([solidus_tote]) }

      context 'that contains page and/or per_page params' do
        let(:query) { { keywords: "Solidus", page: 2, per_page: 2 } }

        it 'ignores the page and per_page params' do
          expect(subject).to match_array([solidus_t_shirt, solidus_mug, solidus_tote])
        end
      end
    end
  end
end
