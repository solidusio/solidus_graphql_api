# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::BatchLoader::HasManyThrough do
  subject(:loader) do
    described_class.new(
      article,
      Article.reflect_on_association(:comment_authors)
    )
  end

  with_model :Article do
    model do
      has_many :comments
      has_many :comment_authors, through: :comments, source: :author
    end
  end

  with_model :Comment do
    table do |t|
      t.belongs_to :article
      t.belongs_to :author
    end

    model do
      belongs_to :article
      belongs_to :author
    end
  end

  with_model :Author do
    model do
      has_many :comments
    end
  end

  let!(:article) { Article.create! }

  before do
    article.comments.create!(author: Author.create!)
  end

  it 'loads the association properly' do
    expect(loader.load.sync).to eq(article.comment_authors)
  end
end
