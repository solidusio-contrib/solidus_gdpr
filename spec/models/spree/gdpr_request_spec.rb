# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::GdprRequest do
  subject(:gdpr_request) { build_stubbed(:gdpr_request) }

  it 'has a valid factory' do
    expect(gdpr_request).to be_valid
  end

  # rubocop:disable SubjectStub
  describe '#create' do
    subject(:gdpr_request) { described_class.new(user: user, intent: :data_restriction) }

    let(:user) { create(:user) }

    before { allow(gdpr_request).to receive(:after_create) }

    it 'calls after_create hook' do
      gdpr_request.save!

      expect(gdpr_request).to have_received(:after_create)
    end
  end
  # rubocop:enable SubjectStub

  describe '#serve' do
    subject(:gdpr_request) { create(:gdpr_request, intent: intent) }

    let(:intent) { :data_restriction }

    # rubocop:disable SubjectStub
    before { allow(gdpr_request).to receive(:after_serve) }

    it 'calls after_serve hook' do
      gdpr_request.serve

      expect(gdpr_request).to have_received(:after_serve)
    end
    # rubocop:enable SubjectStub

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

    context 'when the request is for a resume processing' do
      let(:intent) { :resume_processing }

      let(:data_exporter) { instance_double('SolidusGdpr::DataRestrictor', rollback: %w[foo bar]) }

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
