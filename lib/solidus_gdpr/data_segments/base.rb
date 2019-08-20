# frozen_string_literal: true

module SolidusGdpr
  module DataSegments
    class Base
      # @!attribute [r] user
      #   @return [Spree::User]
      attr_reader :user

      # Initializes the data segment.
      #
      # @param user [Spree::User]
      def initialize(user)
        @user = user
      end

      # Returns a JSON representation of this data segment.
      #
      # This is used by the {DataExporter} service.
      #
      # @return [Object] any object responding to +#to_json+
      def export
        fail NotImplementedError
      end

      # Erases all data contained in this segment.
      #
      # This is used by the {DataEraser} service.
      def erase
        fail NotImplementedError
      end

      # Stops processing of the data contained in this segment.
      #
      # This is used by the {DataRestrictor} service.
      def restrict_processing
        fail NotImplementedError
      end

      # Resumes processing of the data contained in this segment.
      #
      # This is used by the {DataRestrictor} service.
      def resume_processing
        fail NotImplementedError
      end
    end
  end
end
