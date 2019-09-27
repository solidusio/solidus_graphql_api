# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Types::Query do
  it { expect(described_class.method_defined?(:countries)).to be_truthy }
  it { expect(described_class.method_defined?(:orders)).to be_truthy }
end
