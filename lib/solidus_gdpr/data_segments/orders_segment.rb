# frozen_string_literal: true

module SolidusGdpr
  module DataSegments
    # A data segment to represent information about a user's orders.
    #
    # This data segment only implements {DataSegments::Base#export}, as all other GDPR requests
    # should be fulfilled via the {ProfileSegment} data segment.
    class OrdersSegment < Base
      INCLUDES = [
        :shipments,
        line_items: :variant,
        bill_address: [:state, :country],
        ship_address: [:state, :country],
      ].freeze

      # Exports the user's orders.
      #
      # @return [Array<Hash>]
      def export
        user.orders.includes(*INCLUDES).map(&Serializers::OrderSerializer.method(:serialize))
      end
    end
  end
end
