# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Variant::OptionValuesQuery do
  let(:variant) { create(:base_variant) }

  let!(:option_values) { create_list(:option_value, 2, variants: [variant]) }

  it { expect(described_class.new(variant: variant).call.sync).to match_array(option_values) }
end
