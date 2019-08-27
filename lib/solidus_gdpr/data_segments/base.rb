# frozen_string_literal: true

module SolidusGdpr
  module DataSegments
    # An abstract class for defining data segments.
    #
    # A data segment is the representation of a group of data the application holds about a user.
    # For instance, you might have a data segment for basic information about a user's profile,
    # another one for information about their orders etc.
    #
    # Data segments encapsulate the business logic required to operate on the data and fulfill any
    # GDPR-related requests.
    #
    # @abstract To create a data segment, subclass +Base+ and override methods as needed. All of
    #   the overrides are optional and raising +NotImplementedError+ will simply cause the segment
    #   to be ignored when fulfilling GDPR requests.
    class Base
      include SerializerAware

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
