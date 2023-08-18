# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :countries, query: :countries, freeze_date: true do
  connection_field :countries do
    context 'when countries does not exists' do
      it { expect(subject.dig(:data, :countries, :nodes)).to eq [] }
    end

    context 'when countries exists' do
      let!(:us_country) { create(:country, :with_states, id: 1, states_required: false) }
      let!(:it_country) { create(:country, id: 2, iso: 'IT', states_required: false) }

      it { is_expected.to match_response(:countries) }
    end
  end
end
