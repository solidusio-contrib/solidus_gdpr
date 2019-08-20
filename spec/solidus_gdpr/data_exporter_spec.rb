# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataExporter do
  subject(:data_exporter) { described_class.new(user) }

  let(:user) { build_stubbed(:user) }

  let(:profile_segment) do
    instance_double('SolidusGdpr::DataSegments::ProfileSegment', export: {
                      'foo' => 'bar',
                    })
  end

  let(:orders_segment) do
    instance_double('SolidusGdpr::DataSegments::OrdersSegment', export: [
                      { 'foo' => 'bar' },
                    ])
  end

  before do
    allow(SolidusGdpr::DataSegments::ProfileSegment).to receive(:new)
      .with(user)
      .and_return(profile_segment)

    allow(SolidusGdpr::DataSegments::OrdersSegment).to receive(:new)
      .with(user)
      .and_return(orders_segment)
  end

  describe '#run' do
    it 'exports each data segment' do
      expect(data_exporter.run).to eq(
        'profile' => {
          'foo' => 'bar',
        },
        'orders' => [
          { 'foo' => 'bar' },
        ],
      )
    end
  end
end
