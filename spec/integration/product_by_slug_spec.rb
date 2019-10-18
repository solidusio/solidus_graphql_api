# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "ProductBySlug" do
  include_examples 'query is successful', :product_by_slug do
    let!(:product) { create(:product, slug: 'slug') }
  end
end
