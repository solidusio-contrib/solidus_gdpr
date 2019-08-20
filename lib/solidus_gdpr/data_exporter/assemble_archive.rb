# frozen_string_literal: true

module SolidusGdpr
  class DataExporter
    # @api private
    class AssembleArchive
      attr_reader :user, :files

      def initialize(user, files:)
        @user = user
        @files = files
      end

      def call
        export_id = "export-#{user.id}-#{SecureRandom.hex(5)}"
        archive_path = File.join(base_path, "#{export_id}.zip")

        FileUtils.mkdir_p(base_path)

        Zip::File.open(archive_path, Zip::File::CREATE) do |archive|
          files.each_pair do |file_name, file_content|
            archive.get_output_stream(file_name) do |stream|
              stream.write(file_content)
            end
          end
        end

        archive_path
      end

      private

      def base_path
        Rails.root.join('tmp', 'exports')
      end
    end
  end
end
