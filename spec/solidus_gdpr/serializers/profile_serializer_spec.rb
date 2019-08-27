# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Serializers::ProfileSerializer do
  subject(:serializer) { described_class.new(user) }

  let(:user) { create(:user) }

  describe '#as_json' do
    it 'matches the snapshot' do
      expect(prepare_for_snapshot(serializer)).to match_snapshot('serializers/profile_serializer')
    end
  end
end
