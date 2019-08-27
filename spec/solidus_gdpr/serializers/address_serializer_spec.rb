# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Serializers::AddressSerializer do
  subject(:serializer) { described_class.new(address) }

  let(:address) { create(:address) }

  describe '#as_json' do
    it 'matches the snapshot' do
      expect(prepare_for_snapshot(serializer)).to match_snapshot('serializers/address_serializer')
    end
  end
end
