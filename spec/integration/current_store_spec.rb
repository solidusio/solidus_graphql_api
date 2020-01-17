# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :currentStore, query: :current_store, freeze_date: true do
  let!(:store) { create(:store, :with_defaults) }

  let(:query_context) { Hash[current_store: store] }

  field :currentStore do
    it { is_expected.to match_response(:current_store) }
  end
end
