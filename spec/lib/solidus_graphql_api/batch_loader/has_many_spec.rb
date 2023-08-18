# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::BatchLoader::HasMany, skip: (ENV["DB"] == "mysql") do
  include Helpers::ActiveRecord

  subject(:loader) do
    described_class.new(
      article,
      Article.reflect_on_association(:comments)
    )
  end

  before do
    run_migrations do
      create_table :articles, force: true
      create_table :comments, force: true do |t|
        t.belongs_to :article
      end
    end
    create_model("Article") { has_many :comments }
    create_model("Comment") { belongs_to :article }

    article.comments.create!
  end

  after do
    run_migrations do
      drop_table :articles
      drop_table :comments
    end
  end

  let!(:article) { Article.create! }

  it 'loads the association properly' do
    expect(loader.load.sync).to eq(article.comments)
  end
end
