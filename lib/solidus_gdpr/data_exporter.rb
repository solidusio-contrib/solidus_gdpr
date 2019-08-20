# frozen_string_literal: true

module SolidusGdpr
  class DataExporter
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def run
      segments, files = PrepareFiles.new(user).call
      archive_path = AssembleArchive.new(user, files: files).call
      SendArchive.new(user, archive_path: archive_path).call

      segments
    end
  end
end
