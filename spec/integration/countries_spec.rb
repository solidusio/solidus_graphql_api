# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :countries do
  connection_field :countries, query: :countries, freeze_date: true do
    context 'when countries does not exists' do
      it { expect(subject.data.countries.nodes).to be_empty }
    end

    context 'when countries exists' do
      let!(:country) { create(:country, id: 1) }

      before { create(:country, id: 2, iso: 'IT') }

      it { is_expected.to match_response(:countries) }
    end
  end
end
