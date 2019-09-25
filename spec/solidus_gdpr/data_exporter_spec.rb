# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataExporter do
  subject(:data_exporter) { described_class.new(email) }

  let(:email) { 'admin@example.com' }

  describe '#run' do
    it 'assembles and sends the export to the user' do
      segments = %w[profile orders]
      files = { 'profile.json' => 'profile export', 'orders.json' => 'orders export' }
      archive_path = 'archive-path'

      prepare_files = instance_double(
        'SolidusGdpr::DataExporter::PrepareFiles',
        call: [segments, files],
      )
      assemble_archive = instance_double(
        'SolidusGdpr::DataExporter::AssembleArchive',
        call: archive_path,
      )
      send_archive = instance_spy('SolidusGdpr::DataExporter::SendArchive')

      allow(SolidusGdpr::DataExporter::PrepareFiles).to receive(:new)
        .with(email)
        .and_return(prepare_files)

      allow(SolidusGdpr::DataExporter::AssembleArchive).to receive(:new)
        .with(files: files)
        .and_return(assemble_archive)

      allow(SolidusGdpr::DataExporter::SendArchive).to receive(:new)
        .with(email, archive_path: archive_path)
        .and_return(send_archive)

      data_exporter.run

      expect(send_archive).to have_received(:call)
    end
  end
end
