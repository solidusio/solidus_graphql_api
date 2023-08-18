# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::BatchLoader::BelongsTo, skip: (ENV["DB"] == "mysql") do
  include Helpers::ActiveRecord

  subject(:loader) do
    described_class.new(
      object,
      object.class.reflect_on_association(association),
      options
    )
  end

  let(:options) { {} }

  context 'with a regular association' do
    before do
      run_migrations do
        create_table :articles, force: true
        create_table :comments, force: true do |t|
          t.belongs_to :article
        end
      end
      create_model("Article")
      create_model("Comment") { belongs_to :article }
    end

    after do
      run_migrations do
        drop_table :articles
        drop_table :comments
      end
    end

    let!(:object) { Comment.create!(article: Article.create!) }
    let(:association) { :article }

    it 'loads the association properly' do
      expect(loader.load.sync).to eq(object.article)
    end
  end

  context 'with a polymorphic association' do
    before do
      run_migrations do
        create_table :images, force: true do |t|
          t.integer :imageable_id
          t.string :imageable_type
        end
        create_table :articles, force: true
      end
      create_model("Image") { belongs_to :imageable, polymorphic: true }
      create_model("Article") { has_many :images, as: :imageable }
    end

    let!(:object) { Image.create!(imageable: Article.create!) }
    let(:association) { :imageable }
    let(:options) { { klass: Article } }

    it 'loads the association properly' do
      expect(loader.load.sync).to eq(object.imageable)
    end
  end
end
