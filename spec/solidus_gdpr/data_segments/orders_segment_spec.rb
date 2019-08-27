# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataSegments::OrdersSegment do
  subject(:segment) { described_class.new(user) }

  let(:user) { create(:user) }

  describe '#export' do
    let!(:order) { create(:order, user: user) }

    before do
      allow(SolidusGdpr::Serializers::OrderSerializer).to receive(:serialize)
        .with(order)
        .and_return(foo: 'bar')
    end

    it "exports the user's orders" do
      expect(segment.export).to eq([foo: 'bar'])
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
