# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataExporter::PrepareFiles do
  subject(:prepare_files) { described_class.new(user) }

  let(:user) { build_stubbed(:user) }

  let(:profile_segment) do
    instance_double('SolidusGdpr::DataSegments::ProfileSegment', export: {
                      'email' => 'jdoe@example.com',
                    })
  end

  let(:orders_segment) do
    instance_double('SolidusGdpr::DataSegments::OrdersSegment', export: [{
                      'number' => 'R12345678',
                    }])
  end

  before do
    allow(SolidusGdpr::DataSegments::ProfileSegment).to receive(:new)
      .with(user)
      .and_return(profile_segment)

    allow(SolidusGdpr::DataSegments::OrdersSegment).to receive(:new)
      .with(user)
      .and_return(orders_segment)
  end

  describe '#call' do
    it 'returns the segment names and files to include in the export' do
      expect(prepare_files.call).to eq([
                                         %i[profile orders],
                                         {
                                           'profile.json' => {
                                             'email' => 'jdoe@example.com',
                                           }.to_json,
                                           'orders.json' => [{
                                             'number' => 'R12345678',
                                           }].to_json,
                                         },
                                       ])
    end
  end
end
