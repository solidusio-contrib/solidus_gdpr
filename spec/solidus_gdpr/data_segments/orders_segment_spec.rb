# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataSegments::OrdersSegment do
  subject(:segment) { described_class.new(user.email) }

  let(:user) { create(:user, email: 'guest@example.com') }

  let!(:order) { create(:order, user: user) }
  let!(:guest_order) do
    create(:order, user: user).tap do |order|
      order.update!(email: user.email)
    end
  end

  before { create(:admin_user) }

  describe '#export' do
    before do
      allow(SolidusGdpr::Serializers::OrderSerializer).to receive(:serialize)
        .with(order)
        .and_return(order: 'bar')

      allow(SolidusGdpr::Serializers::OrderSerializer).to receive(:serialize)
        .with(guest_order)
        .and_return(guest_order: 'foo')
    end

    it "exports the user's orders" do
      expect(segment.export).to eq([{ order: 'bar' }, { guest_order: 'foo' }])
    end
  end

  describe '#erase' do
    before { segment.erase }

    it "scrambles the order's email" do
      expect(order.reload.email).not_to eq(user.email)
    end

    it "scrambles the guest order's email" do
      expect(guest_order.reload.email).not_to eq(user.email)
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
