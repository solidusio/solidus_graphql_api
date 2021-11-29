# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'JSON type' do
  it 'coerces JSON custom type', type: :feature do
    create(:product, name: 'Shirt')

    post '/graphql',
      params: {
        query: "{ products(query: { search: { name_cont: \"Shirt\" } }) { nodes { name } } }"
      },
      headers: headers

    expect(JSON.parse(response.body).dig(*%w[data products nodes])[0]['name']).to eq('Shirt')
  end
end
