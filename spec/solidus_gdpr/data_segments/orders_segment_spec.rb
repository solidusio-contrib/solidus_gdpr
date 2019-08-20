# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataSegments::OrdersSegment do
  subject(:segment) { described_class.new(user) }

  let(:user) { build_stubbed(:user) }

  describe '#export' do
    let(:order) { build_stubbed(:order) }

    before do
      allow(user).to receive(:orders)
        .and_return([order])
    end

    it "exports the user's orders" do
      expect(segment.export).to match_array([a_hash_including(
        'number' => order.number,
      )])
    end
  end

  describe '#erase' do
    it 'is a no-op' do
      expect { segment.erase }.to raise_error(NotImplementedError)
    end
  end

  describe '#restrict_processing' do
    it 'is a no-op' do
      expect { segment.restrict_processing }.to raise_error(NotImplementedError)
    end
  end

  describe '#resume_processing' do
    it 'is a no-op' do
      expect { segment.resume_processing }.to raise_error(NotImplementedError)
    end
  end
end
