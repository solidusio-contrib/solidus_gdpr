# frozen_string_literal: true

module SolidusGdpr
  # Exports all configured data segments for a given user.
  class DataExporter
    # @return [String] the email to retrieve the user and the orders
    attr_reader :email

    # Initializes the data exporter.
    #
    # @param user [String] the email to retrieve the user and the orders
    def initialize(email)
      @email = email
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
      segments, files = PrepareFiles.new(email).call
      archive_path = AssembleArchive.new(files: files).call
      SendArchive.new(email, archive_path: archive_path).call

      segments
    end
  end
end
