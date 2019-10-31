# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::User do
  subject(:user) { create(:user) }

  describe '.data_processable' do
    let!(:data_processable_user) { create(:user) }

    before { create(:user, data_processable: false) }

    it 'returns users whose data is processable' do
      expect(described_class.data_processable).to eq([data_processable_user])
    end
  end

  describe '.data_restricted' do
    let!(:data_restricted_user) { create(:user, data_processable: false) }

    before { create(:user) }

    it 'returns users whose data is processable' do
      expect(described_class.data_restricted).to eq([data_restricted_user])
    end
  end
end
