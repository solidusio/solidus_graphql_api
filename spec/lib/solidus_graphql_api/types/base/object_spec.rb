# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Types::Base::Object do
  subject do
    Class.new(described_class) do
      graphql_name :test
    end
  end

  describe '.remove_field' do
    context 'when the field is defined' do
      before do
        subject.field :name, String, null: false
      end

      it 'removes the field' do
        expect {
          subject.remove_field :name
        }.to change { subject.own_fields['name'] }.to(nil)
      end
    end

    context 'when the field is not defined' do
      it 'raises an ArgumentError' do
        expect {
          subject.remove_field :name
        }.to raise_error(ArgumentError)
      end
    end
  end
end
