# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::Schema do
  it 'current schema is identical to desired schema' do
    expected_schema = File.read("#{SolidusGraphqlApi::Engine.root}/spec/expected_schema.graphql")
    current_schema = Spree::Graphql::Schema.to_definition

    result = GraphQL::SchemaComparator.compare(current_schema, expected_schema)

    expect(result.identical?).to be_truthy, result.changes.map(&:message).join("\n")
  end

  describe '.id_from_object' do
    subject { described_class.id_from_object(object, nil, nil) }

    context 'when object responds to :id' do
      let(:object) { build(:country, id: 1) }

      after { subject }

      it { expect(::GraphQL::Schema::UniqueWithinType).to receive(:encode).with('Spree::Country', 1) }
    end

    context 'when object does not respond to :id' do
      let(:object) { nil }

      it { expect { subject }.to raise_error(NoMethodError) }
    end
  end

  describe '.object_from_id' do
    subject { described_class.object_from_id('ID', nil) }

    let!(:object) { create(:country) }
    let(:klass) { 'Spree::Country' }
    let(:id) { object.id }

    before do
      allow(::GraphQL::Schema::UniqueWithinType).to receive(:decode).and_return([klass, id])
    end

    context 'when the class and the id exist' do
      it { is_expected.to eq object }
    end

    context 'when the class does not exist' do
      let(:klass) { 'NotExistingClass' }

      it { expect { subject }.to raise_error(NameError) }
    end

    context 'when the id does not exist' do
      let(:id) { Spree::Country.maximum(:id).next }

      it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end

  describe '.resolve_type' do
    subject { described_class.resolve_type(nil, object, nil) }

    context 'when graphql type exists' do
      let(:object) { build(:country) }

      # rubocop:disable Style/ClassAndModuleChildren
      class Spree::Graphql::Types::Country < Spree::Graphql::Types::Base::RelayNode; end
      # rubocop:enable Style/ClassAndModuleChildren

      it { is_expected.to eq Spree::Graphql::Types::Country.graphql_definition }
    end

    context 'when graphql type does not exist' do
      let(:object) { double(:not_existing) }

      it { expect { subject }.to raise_error(NameError) }
    end
  end
end
