# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Serializers::LineItemSerializer do
  subject(:serializer) { described_class.new(line_item) }

  let(:line_item) { create(:line_item) }

  describe '#as_json' do
    it 'matches the snapshot' do
      expect(prepare_for_snapshot(serializer)).to match_snapshot('serializers/line_item_serializer')
    end
  end
end
