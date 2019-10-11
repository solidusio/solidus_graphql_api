# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Products" do
  include_examples 'query is successful', :products do
    let(:product_nodes) { subject.data.products.nodes }

    before do
      create_list(:product, 2)
    end

    it { expect(product_nodes).to be_present }
  end
end
