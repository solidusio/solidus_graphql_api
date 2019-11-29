# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::ProductsQuery do
  subject { described_class.new.call }

  let!(:products) { create_list(:product, 2) }

  it { is_expected.to match_array(products) }
end
