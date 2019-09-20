# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Countries" do
  include_examples 'query is successful', :countries do
    let(:country_nodes) { subject.data.countries.nodes }
    let(:state_nodes) { country_nodes.map { |c| c.states.nodes }.flatten }

    before do
      create_list(:state, 2)
      create_list(:state, 2, country_iso: 'IT')
    end

    it { expect(country_nodes).to be_present }

    it { expect(state_nodes).to be_present }
  end
end
