# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::GraphqlController do
  let(:context) { Hash[] }

  before { allow_any_instance_of(SolidusGraphqlApi::Context).to receive(:to_h).and_return(context) }

  it 'passes the right context to the schema' do
    expect(SolidusGraphqlApi::Schema).to receive(:execute).with(
      nil, hash_including(context: context)
    )

    post '/graphql', headers: headers
  end

  it 'can return blob URLs on disk storage' do
    product = create(:product)
    product.images.create(attributes_for(:image))

    post '/graphql',
         params: {
           query: "{ productBySlug(slug: \"#{product.slug}\") { masterVariant { images { nodes { smallUrl } } } } }"
         },
         headers: headers

    expect(JSON.parse(response.body).dig(*%w[data productBySlug masterVariant images nodes])[0]['smallUrl']).to match('http://')
  end
end
