# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::GraphqlController do
  let(:context) { Hash[] }

  before { allow_any_instance_of(SolidusGraphqlApi::Context).to receive(:to_h).and_return(context) }

  after { post '/graphql', headers: headers }

  it 'passes the right context to the schema' do
    expect(SolidusGraphqlApi::Schema).to receive(:execute).with(
      nil, hash_including(context: context)
    )
  end
end
