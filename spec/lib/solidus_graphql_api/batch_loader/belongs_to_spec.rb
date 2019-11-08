# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::BatchLoader::BelongsTo do
  subject(:loader) do
    described_class.new(
      object,
      object.class.reflect_on_association(association),
      options
    )
  end

  let(:options) { {} }

  context 'with a regular association' do
    with_model :Article, scope: :all do
      model do
        has_many :comments
      end
    end

    with_model :Comment, scope: :all do
      table do |t|
        t.belongs_to :article
      end

      model do
        belongs_to :article
      end
    end

    let!(:object) { Comment.create!(article: Article.create!) }
    let(:association) { :article }

    it 'loads the association properly' do
      expect(loader.load.sync).to eq(object.article)
    end
  end

  context 'with a polymorphic association' do
    with_model :Image, scope: :all do
      table do |t|
        t.integer :imageable_id
        t.string :imageable_type
      end

      model do
        belongs_to :imageable, polymorphic: true
      end
    end

    with_model :Article, scope: :all do
      model do
        has_many :images, as: :imageable
      end
    end

    let!(:object) { Image.create!(imageable: Article.create!) }
    let(:association) { :imageable }
    let(:options) { { klass: Article } }

    it 'loads the association properly' do
      expect(loader.load.sync).to eq(object.imageable)
    end
  end
end
