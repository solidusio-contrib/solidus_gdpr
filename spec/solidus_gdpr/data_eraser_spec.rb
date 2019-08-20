# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataEraser do
  subject(:data_eraser) { described_class.new(user) }

  let(:user) { build_stubbed(:user) }

  let(:profile_segment) { instance_spy('SolidusGdpr::DataSegments::ProfileSegment') }
  let(:orders_segment) { instance_spy('SolidusGdpr::DataSegments::OrdersSegment') }

  before do
    allow(SolidusGdpr::DataSegments::ProfileSegment).to receive(:new)
      .with(user)
      .and_return(profile_segment)

    allow(SolidusGdpr::DataSegments::OrdersSegment).to receive(:new)
      .with(user)
      .and_return(orders_segment)
  end

  describe '#run' do
    it 'erases each data segment' do # rubocop:disable RSpec/MultipleExpectations
      data_eraser.run

      expect(profile_segment).to have_received(:erase)
      expect(orders_segment).to have_received(:erase)
    end
  end
end
