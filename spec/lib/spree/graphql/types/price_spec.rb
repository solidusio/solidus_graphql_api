# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Types::Price do
  it { expect(described_class.method_defined?(:currency_symbol)).to be_truthy }
end
