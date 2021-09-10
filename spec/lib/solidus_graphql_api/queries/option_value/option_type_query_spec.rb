# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::OptionValue::OptionTypeQuery do
  let(:option_type) { create(:option_type) }
  let(:option_value) { create(:option_value, option_type: option_type) }

  it { expect(described_class.new(option_value: option_value).call.sync).to eq(option_type) }
end
