# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "Current User" do
  include_examples 'query is successful', :currentUser do
    let(:user) { create(:user) }
    let(:context) { Hash[current_user: user] }

    it { expect(subject.data.currentUser).to_not be_nil }
  end
end
