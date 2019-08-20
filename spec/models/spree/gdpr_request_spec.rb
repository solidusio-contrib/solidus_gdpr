# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::GdprRequest do
  subject(:gdpr_request) { build_stubbed(:gdpr_request) }

  it 'has a valid factory' do
    expect(gdpr_request).to be_valid
  end

  describe '#serve' do
    subject(:gdpr_request) { create(:gdpr_request, intent: intent) }

    context 'when the request is for a data export' do
      let(:intent) { :data_export }

      let(:data_exporter) { instance_double('SolidusGdpr::DataExporter', run: %w[foo bar]) }

      before do
        allow(SolidusGdpr::DataExporter).to receive(:new)
          .with(gdpr_request.user)
          .and_return(data_exporter)
      end

      it 'returns the list of processed segments' do
        expect(gdpr_request.serve).to eq(%w[foo bar])
      end

      it 'marks the request as served' do
        expect { gdpr_request.serve }.to change(gdpr_request, :served_at).from(nil)
      end
    end

    context 'when the request is for a data erasure' do
      let(:intent) { :data_erasure }

      let(:data_exporter) { instance_double('SolidusGdpr::DataEraser', run: %w[foo bar]) }

      before do
        allow(SolidusGdpr::DataEraser).to receive(:new)
          .with(gdpr_request.user)
          .and_return(data_exporter)
      end

      it 'returns the list of processed segments' do
        expect(gdpr_request.serve).to eq(%w[foo bar])
      end

      it 'marks the request as served' do
        expect { gdpr_request.serve }.to change(gdpr_request, :served_at).from(nil)
      end
    end

    context 'when the request is for a data restriction' do
      let(:intent) { :data_restriction }

      let(:data_exporter) { instance_double('SolidusGdpr::DataRestrictor', run: %w[foo bar]) }

      before do
        allow(SolidusGdpr::DataRestrictor).to receive(:new)
          .with(gdpr_request.user)
          .and_return(data_exporter)
      end

      it 'returns the list of processed segments' do
        expect(gdpr_request.serve).to eq(%w[foo bar])
      end

      it 'marks the request as served' do
        expect { gdpr_request.serve }.to change(gdpr_request, :served_at).from(nil)
      end
    end
  end
end
