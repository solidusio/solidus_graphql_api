# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::OptionValue do
  let(:option_value) { create(:option_value) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, option_value, {}) }

  describe '#option_type' do
    before do
      allow(SolidusGraphqlApi::Queries::OptionValue::OptionTypeQuery).
        to receive(:new).with(option_value: option_value).
        and_return(query_object)
    end

    after { subject.option_type }

    it { expect(query_object).to receive(:call) }
  end
end
