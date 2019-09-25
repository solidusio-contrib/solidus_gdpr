# frozen_string_literal: true

module SolidusGdpr
  class DataExporter
    # @api private
    class SendArchive
      attr_reader :email, :archive_path

      def initialize(email, archive_path:)
        @email = email
        @archive_path = archive_path
      end

      def call
        SolidusGdpr.configuration.exports_mailer_class.constantize.export_email(
          email,
          export: File.read(archive_path),
        ).deliver_now
      end
    end
  end
end
