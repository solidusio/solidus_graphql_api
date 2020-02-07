# frozen_string_literal: true

RSpec.shared_examples 'query is successful' do |query|
  subject { execute_query(query, variables: variables, context: context) }

  let(:context) { nil }
  let(:variables) { Hash[] }

  it { expect{ subject }.to_not raise_error }

  it { expect(subject[:errors]).to be_nil }
end
