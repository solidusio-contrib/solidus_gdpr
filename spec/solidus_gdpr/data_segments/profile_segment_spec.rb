# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataSegments::ProfileSegment do
  subject(:segment) { described_class.new(user) }

  describe '#export' do
    let(:user) { create(:user) }

    before do
      allow(SolidusGdpr::Serializers::ProfileSerializer).to receive(:serialize)
        .with(user)
        .and_return(foo: 'bar')
    end

    it "exports the user's profile" do
      expect(segment.export).to eq(foo: 'bar')
    end
  end

  describe '#erase' do
    let(:user) { instance_spy('Spree::User') }

    it "scrambles the user's email" do
      segment.erase

      expect(user).to have_received(:update!)
        .with(email: an_instance_of(String))
    end
  end

  describe '#restrict_processing' do
    let(:user) { instance_spy('Spree::User') }

    it "restricts processing of the user's data" do
      segment.restrict_processing

      expect(user).to have_received(:update!)
        .with(data_processable: false)
    end
  end

  describe '#resume_processing' do
    let(:user) { instance_spy('Spree::User') }

    it "resumes processing of the user's data" do
      segment.resume_processing

      expect(user).to have_received(:update!)
        .with(data_processable: true)
    end
  end
end
