# frozen_string_literal: true

module SolidusGdpr
  module DataSegments
    # A data segment to represent information about a user's profile.
    class ProfileSegment < Base
      # Exports the user's profile
      #
      # @return [Hash]
      def export
        serialize(user, with: :profile)
      end

      # Erases the data segment.
      #
      # This will scramble the user's email.
      def erase
        user.update!(email: "#{SecureRandom.hex(10)}@example.com")
      end

      # Restricts processing of the user's profile.
      #
      # This will set +data_processable+ to +false+ in +spree_users+.
      def restrict_processing
        user.update!(data_processable: false)
      end

      # Resumes processing of the user's profile.
      #
      # This will set +data_processable+ to +true+ in +spree_users+.
      def resume_processing
        user.update!(data_processable: true)
      end
    end
  end
end
