# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataRestrictor do
  subject(:data_restrictor) { described_class.new(user) }

  let(:user) { build_stubbed(:user) }

  let(:profile_segment) { instance_spy('SolidusGdpr::DataSegments::ProfileSegment') }
  let(:orders_segment) { instance_double('SolidusGdpr::DataSegments::OrdersSegment') }

  before do
    allow(SolidusGdpr::DataSegments::ProfileSegment).to receive(:new)
      .with(user)
      .and_return(profile_segment)

    allow(SolidusGdpr::DataSegments::OrdersSegment).to receive(:new)
      .with(user)
      .and_return(orders_segment)
  end

  describe '#run' do
    before do
      allow(orders_segment).to receive(:restrict_processing)
        .and_raise(NotImplementedError)
    end

    it 'restricts processing of each segment' do
      data_restrictor.run

      expect(profile_segment).to have_received(:restrict_processing)
    end
  end

  describe '#rollback' do
    before do
      allow(orders_segment).to receive(:resume_processing)
        .and_raise(NotImplementedError)
    end

    it 'resumes processing of each segment' do
      data_restrictor.rollback

      expect(profile_segment).to have_received(:resume_processing)
    end
  end
end
