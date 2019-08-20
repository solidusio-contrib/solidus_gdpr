# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataExporter::SendArchive do
  subject(:send_archive) { described_class.new(user, archive_path: archive_path) }

  let(:user) { build_stubbed(:user) }
  let(:archive_path) { Rails.root.join('tmp', "test-#{SecureRandom.hex(10)}") }

  before { File.write(archive_path, 'hello') }

  describe '#call' do
    it 'sends the ZIP archive to the user' do
      email = instance_spy('ActionMailer::Delivery')
      allow(Spree::GdprExportsMailer).to receive(:export_email)
        .with(user, export: 'hello')
        .and_return(email)

      send_archive.call

      expect(email).to have_received(:deliver_now)
    end
  end
end
