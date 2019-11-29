# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Current Store" do
  include_examples 'query is successful', :currentStore do
    let(:store) { create(:store) }
    let(:context) { Hash[current_store: store] }

    it { expect(subject.data.currentStore).to_not be_nil }
  end
end
