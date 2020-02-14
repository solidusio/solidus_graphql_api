# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::LineItem::VariantQuery do
  let(:line_item) { create(:line_item) }

  it { expect(described_class.new(line_item: line_item).call.sync).to eq(line_item.variant) }
end
