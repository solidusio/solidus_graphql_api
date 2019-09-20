# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Countries" do
  include_examples 'query is successful', :countries do
    let!(:countries) { create_list(:country, 2) }

    it { expect(subject.data.countries.nodes).to_not be_empty }
  end
end
