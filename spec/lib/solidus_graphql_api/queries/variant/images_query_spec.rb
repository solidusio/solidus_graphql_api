# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGraphqlApi::Queries::Variant::ImagesQuery do
  let(:variant) { create(:variant) }

  let!(:images) { create_list(:image, 2, viewable: variant ) }

  it { expect(described_class.new(variant: variant).call.sync).to match_array(images) }
end
