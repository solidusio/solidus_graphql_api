# frozen_string_literal: true

RSpec.shared_examples 'query is successful' do |query|
  subject { execute_query(query) }

  it { expect{ subject }.to_not raise_error }
end
