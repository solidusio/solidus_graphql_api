# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_query :countries do
  connection_field :countries, query: :countries, freeze_date: true do
    context 'when countries does not exists' do
      it { expect(subject.dig(:data, :countries, :nodes)).to eq [] }
    end

    context 'when countries exists' do
      let!(:country) { create(:country, id: 1) }

      before { create(:country, id: 2, iso: 'IT') }

      it { is_expected.to match_response(:countries) }

      connection_field :states, query: 'countries/states' do
        context 'when states does not exists' do
          it { is_expected.to match_response('countries/empty_states') }
        end

        context 'when states exists' do
          before do
            create(:state, id: 1, country: country)
            create(:state, id: 2, country: country, state_code: 'CA')
          end

          it { is_expected.to match_response('countries/states') }
        end
      end
    end
  end
end
