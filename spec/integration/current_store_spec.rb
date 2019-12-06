# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :currentStore, query: :current_store, freeze_date: true do
  let!(:store) do
    create(:store,
           cart_tax_country_iso: 'US',
           code: 'spree',
           default_currency: 'USD',
           meta_description: 'store description',
           meta_keywords: 'store, metaKeywords',
           name: 'Spree Test Store',
           seo_title: 'Store Title',
           url: 'www.example.com')
  end

  let(:query_context) { Hash[current_store: store] }

  field :currentStore do
    it { is_expected.to match_response(:current_store) }
  end
end
