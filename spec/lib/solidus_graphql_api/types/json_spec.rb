# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::Json do
  describe '.coerce_input' do
    subject { described_class.coerce_input(value, nil) }

    let(:value) do
      {
        number: 1,
        string: 'string',
        id: 'U3ByZWU6OkNvdW50cnktMQ==', # Spree::Country-1
        generic_base64: 'U3ByZWU6OkNvdW50cnktdGVzdA==', # Spree::Country-test
        strings_array: [
          'string1', 'string2'
        ],
        numbers_array: [
          1, 2
        ],
        ids_array: [
          'U3ByZWU6OkNvdW50cnktMg==', 'U3ByZWU6OkNvdW50cnktMw==' # Spree::Country-2, Spree::Country-3
        ],
        generic_base64_array: [
          'VGVzdDE=', 'VGVzdDI=' # Test1, Test2
        ]
      }
    end

    let(:result) do
      {
        number: 1,
        string: 'string',
        id: 1,
        generic_base64: 'U3ByZWU6OkNvdW50cnktdGVzdA==',
        strings_array: [
          'string1', 'string2'
        ],
        numbers_array: [
          1, 2
        ],
        ids_array: [
          2, 3
        ],
        generic_base64_array: [
          'VGVzdDE=', 'VGVzdDI='
        ]
      }
    end

    it { is_expected.to eq(result) }
  end
end
