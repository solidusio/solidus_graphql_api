# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::CountriesQuery do
  subject { described_class.new.call }

  let!(:countries) { create_list(:country, 2) }

  it { is_expected.to eq(countries) }
end
