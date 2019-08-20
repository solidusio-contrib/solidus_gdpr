# frozen_string_literal: true

module SolidusGdpr
  module DataSegments
    class ProfileSegment < Base
      def export
        {
          'email' => user.email,
        }
      end

      def erase
        user.update!(email: "#{SecureRandom.hex(10)}@example.com")
      end

      def restrict_processing
        user.update!(data_processable: false)
      end

      def resume_processing
        user.update!(data_processable: true)
      end
    end
  end
end
