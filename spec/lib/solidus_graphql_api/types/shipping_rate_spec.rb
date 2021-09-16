# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::ShippingRate do
  let(:shipping_rate) { create(:shipping_rate) }
  let(:query_object) { spy(:query_object) }

  subject { described_class.send(:new, shipping_rate, {}) }

  describe '#shipping_method' do
    before do
      allow(SolidusGraphqlApi::Queries::ShippingRate::ShippingMethodQuery).
        to receive(:new).with(shipping_rate: shipping_rate).
        and_return(query_object)
    end

    after { subject.shipping_method }

    it { expect(query_object).to receive(:call) }
  end
end
