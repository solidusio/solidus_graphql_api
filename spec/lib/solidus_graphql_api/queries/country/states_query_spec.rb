# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Country::StatesQuery do
  let(:country) { create(:country) }

  let!(:states) { create_list(:state, 2, country: country) }

  it { expect(described_class.new(country: country).call.sync).to match_array(states) }
end
