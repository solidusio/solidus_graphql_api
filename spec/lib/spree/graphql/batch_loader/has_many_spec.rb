# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::Graphql::BatchLoader::HasMany do
  subject(:loader) do
    described_class.new(
      article,
      Article.reflect_on_association(:comments)
    )
  end

  with_model :Article do
    model do
      has_many :comments
    end
  end

  with_model :Comment do
    table do |t|
      t.belongs_to :article
    end

    model do
      belongs_to :article
    end
  end

  let!(:article) { Article.create! }

  before do
    article.comments.create!
  end

  it 'loads the association properly' do
    expect(loader.load.sync).to eq(article.comments)
  end
end
