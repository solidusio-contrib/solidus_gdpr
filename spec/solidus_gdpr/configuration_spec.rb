# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Configuration do
  subject(:configuration) { described_class.new }

  describe '#segments' do
    it 'returns the Solidus segments' do
      expect(configuration.segments).to eq(
        'profile' => SolidusGdpr::DataSegments::ProfileSegment,
        'orders' => SolidusGdpr::DataSegments::OrdersSegment,
      )
    end
  end
end
