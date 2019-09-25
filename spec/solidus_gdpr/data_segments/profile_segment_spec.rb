# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataSegments::ProfileSegment do
  subject(:segment) { described_class.new(email) }

  let(:email) { 'admin@example.com' }

  describe '#export' do
    context 'when there is a user with that email' do
      let!(:user) { create(:user, email: email) }

      before do
        allow(SolidusGdpr::Serializers::ProfileSerializer).to receive(:serialize)
          .with(user)
          .and_return(foo: 'bar')
      end

      it "exports the user's profile" do
        expect(segment.export).to eq(foo: 'bar')
      end
    end

    context "when there isn't a user with that email" do
      it 'is a no-op' do
        expect(segment.export).to eq(nil)
      end
    end
  end

  describe '#erase' do
    context 'when there is a user with that email' do
      let!(:user) { create(:user, email: email) }

      it "scrambles the user's email" do
        expect {
          segment.erase
          user.reload
        }.to change(user, :email)
      end
    end

    context "when there isn't a user with that email" do
      it "doesn't raise an exception" do
        expect { segment.erase }.not_to raise_error
      end
    end
  end

  describe '#restrict_processing' do
    context 'when there is a user with that email' do
      let!(:user) { create(:user, email: email) }

      it "restricts processing of the user's data" do
        expect {
          segment.restrict_processing
          user.reload
        }.to change(user, :data_processable).to(false)
      end
    end

    context "when there isn't a user with that email" do
      it "doesn't raise an exception" do
        expect { segment.restrict_processing }.not_to raise_error
      end
    end
  end

  describe '#resume_processing' do
    context 'when there is a user with that email' do
      let!(:user) { create(:user, email: email, data_processable: false) }

      it "resumes processing of the user's data" do
        expect {
          segment.resume_processing
          user.reload
        }.to change(user, :data_processable).to(true)
      end
    end

    context "when there isn't a user with that email" do
      it "doesn't raise an exception" do
        expect { segment.resume_processing }.not_to raise_error
      end
    end
  end
end
