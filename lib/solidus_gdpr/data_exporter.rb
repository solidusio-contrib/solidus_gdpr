# frozen_string_literal: true

module SolidusGdpr
  # Exports all configured data segments for a given user.
  class DataExporter
    # @return [Spree::User] the user to export
    attr_reader :user

    # Initializes the data exporter.
    #
    # @param user [Spree::User] the user to export
    def initialize(user)
      @user = user
    end

    # Creates a ZIP archive with the user's data export.
    #
    # Walks through all configured data segments, exporting each one. Then creates a ZIP archive
    # with JSON files named after the respective data segments. The archive is sent to the user via
    # the +#export_email+ method on {Configuration.exports_mailer_class}.
    #
    # If a data segment's {DataSegments::Base#export} method raises a +NotImplementedError+, then
    # the segment is ignored.
    #
    # @return [Array<String>] the names of the exported data segments
    def run
      segments, files = PrepareFiles.new(user).call
      archive_path = AssembleArchive.new(user, files: files).call
      SendArchive.new(user, archive_path: archive_path).call

      segments
    end
  end
end
