# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::GraphqlController do
  shared_examples 'passes the right user in the context' do
    before do
      user.generate_spree_api_key!
    end

    after do
      post '/', headers: headers
    end

    it 'passes the right user in the context' do
      expect(Spree::Graphql::Schema).to receive(:execute).with(
        nil, hash_including(context: context)
      )
    end
  end

  let(:user) { create(:user) }
  let(:context) { Hash[current_user: nil] }
  let(:headers) { Hash[] }

  context 'when no token is present' do
    include_examples 'passes the right user in the context'
  end

  context 'when token is invalid' do
    let(:headers) { Hash["Authorization" => "Bearer INVALID"] }

    include_examples 'passes the right user in the context'
  end

  context 'when token is valid' do
    let(:context) { Hash[current_user: user] }
    let(:headers) { Hash["Authorization" => "Bearer #{user.spree_api_key}"] }

    include_examples 'passes the right user in the context'
  end
end
