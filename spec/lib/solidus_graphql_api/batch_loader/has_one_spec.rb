# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::BatchLoader::HasOne do
  subject(:loader) do
    described_class.new(
      article,
      Article.reflect_on_association(:image)
    )
  end

  with_model :Article, scope: :all do
    model do
      has_one :image
    end
  end

  with_model :Image, scope: :all do
    table do |t|
      t.belongs_to :article
    end

    model do
      belongs_to :article
    end
  end

  let!(:article) { Article.create! }

  before do
    article.create_image!
  end

  it 'loads the association properly' do
    expect(loader.load.sync).to eq(article.image)
  end
end
