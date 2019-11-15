# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::OptionType do
  it { expect(described_class.method_defined?(:option_values)).to be_truthy }
end
