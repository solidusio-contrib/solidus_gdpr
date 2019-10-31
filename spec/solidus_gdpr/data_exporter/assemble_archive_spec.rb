# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::DataExporter::AssembleArchive do
  subject(:assemble_archive) { described_class.new(files: files) }

  let(:files) do
    {
      'profile.json' => 'profile export content',
    }
  end

  describe '#call' do
    it 'assembles a ZIP archive with the files' do
      archive_path = assemble_archive.call

      zip_entries = {}
      Zip::File.open(archive_path) do |zip_file|
        zip_file.each do |entry|
          zip_entries[entry.name] = entry.get_input_stream.read
        end
      end

      expect(zip_entries).to eq(files)
    end
  end
end
