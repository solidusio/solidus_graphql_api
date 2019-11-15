# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::Country do
  it { expect(described_class.method_defined?(:states)).to be_truthy }
end
