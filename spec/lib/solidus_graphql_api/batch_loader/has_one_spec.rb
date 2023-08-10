# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::BatchLoader::HasOne, skip: (ENV["DB"] == "mysql") do
  include Helpers::ActiveRecord

  subject(:loader) do
    described_class.new(
      article,
      Article.reflect_on_association(:image)
    )
  end

  before do
    run_migrations do
      create_table :articles, force: true
      create_table :images, force: true do |t|
        t.belongs_to :article
      end
    end
    create_model("Article") { has_one :image }
    create_model("Image") { belongs_to :article }

    article.create_image!
  end

  after do
    run_migrations do
      drop_table :articles
      drop_table :images
    end
  end

  let!(:article) { Article.create! }

  it 'loads the association properly' do
    expect(loader.load.sync).to eq(article.image)
  end
end
