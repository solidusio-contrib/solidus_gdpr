# frozen_string_literal: true

module SolidusGdpr
  module DataSegments
    class OrdersSegment < Base
      def export
        user.orders.map do |order|
          {
            'number' => order.number,
          }
        end
      end
    end
  end
end
