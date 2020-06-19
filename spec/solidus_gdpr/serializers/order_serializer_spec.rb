# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Serializers::OrderSerializer do
  subject(:serializer) { described_class.new(order) }

  let(:order) { create(:completed_order_with_totals) }

  describe '#as_json' do
    it 'matches the snapshot' do
      if ::Spree::Config.has_preference?(:use_combined_first_and_last_name_in_address) && ::Spree::Config.use_combined_first_and_last_name_in_address
        expect(prepare_for_snapshot(serializer)).to match_snapshot('serializers/order_serializer')
      else
        expect(prepare_for_snapshot(serializer)).to match_snapshot('serializers/legacy_order_serializer')
      end
    end
  end
end
