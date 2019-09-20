# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Taxonomies" do
  include_examples 'query is successful', :taxonomies do
    let!(:taxonomies) { create_list(:taxonomy, 2) }

    it { expect(subject.data.taxonomies.nodes).to_not be_empty }
  end
end
