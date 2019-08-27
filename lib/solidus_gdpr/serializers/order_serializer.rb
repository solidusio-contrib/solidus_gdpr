# frozen_string_literal: true

module SolidusGdpr
  module Serializers
    # @api private
    class OrderSerializer < BaseSerializer
      def as_json(*)
        {
          number: object.number,
          item_total: object.item_total,
          total: object.total,
          adjustment_total: object.adjustment_total,
          user_id: object.user_id,
          completed_at: object.completed_at,
          bill_address: serialize(object.bill_address, with: :address),
          ship_address: serialize(object.ship_address, with: :address),
          payment_total: object.payment_total,
          email: object.email,
          special_instructions: object.special_instructions,
          currency: object.currency,
          shipment_total: object.shipment_total,
          additional_tax_total: object.additional_tax_total,
          promo_total: object.promo_total,
          included_tax_total: object.included_tax_total,
          item_count: object.item_count,
          line_items: serialize(object.line_items, with: :line_item),
          shipments: serialize(object.shipments, with: :shipment),
        }
      end
    end
  end
end
