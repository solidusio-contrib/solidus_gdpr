# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Serializers::ShipmentSerializer do
  subject(:serializer) { described_class.new(shipment) }

  let(:shipment) { create(:shipment) }

  describe '#as_json' do
    it 'matches the snapshot' do
      expect(prepare_for_snapshot(serializer)).to match_snapshot('serializers/shipment_serializer')
    end
  end
end
