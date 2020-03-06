# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :currentOrder, query: :current_order, freeze_date: true do
  let!(:order) { create :order, id: 1, number: 'fake number' }

  let(:query_context) { { current_order: order } }

  field :currentOrder do
    it { is_expected.to match_response(:current_order) }
  end
end
