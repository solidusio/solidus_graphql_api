# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Queries::Country::StatesQuery do
  let(:country) { create(:country) }

  let!(:states) { create_list(:state, 2, country: country) }

  it { expect(described_class.new(country).call.sync).to eq(states) }
end
