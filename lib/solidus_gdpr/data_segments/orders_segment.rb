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
        serialize(orders, with: :order)
      end

      # Erases the data segment.
      #
      # This will scramble the order's email.
      def erase
        orders.update(email: SolidusGdpr.configuration.erased_email.call)
      end

      private

      # Returns the list of the user's orders using the email
      #
      # @return [Spree::Order::ActiveRecord_Relation]
      def orders
        ::Spree::Order
          .left_outer_joins(:user)
          .where('spree_orders.email = ? OR spree_users.email = ?', email, email)
      end
    end
  end
end
