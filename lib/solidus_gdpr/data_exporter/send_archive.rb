# frozen_string_literal: true

module SolidusGdpr
  class DataExporter
    # @api private
    class SendArchive
      attr_reader :user, :archive_path

      def initialize(user, archive_path:)
        @user = user
        @archive_path = archive_path
      end

      def call
        SolidusGdpr.configuration.exports_mailer_class.constantize.export_email(
          user,
          export: File.read(archive_path),
        ).deliver_now
      end
    end
  end
end
