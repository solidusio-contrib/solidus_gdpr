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
          bill_address: AddressSerializer.serialize(object.bill_address),
          ship_address: AddressSerializer.serialize(object.ship_address),
          payment_total: object.payment_total,
          email: object.email,
          special_instructions: object.special_instructions,
          currency: object.currency,
          shipment_total: object.shipment_total,
          additional_tax_total: object.additional_tax_total,
          promo_total: object.promo_total,
          included_tax_total: object.included_tax_total,
          item_count: object.item_count,
          line_items: object.line_items.map(&LineItemSerializer.method(:serialize)),
          shipments: object.shipments.map(&ShipmentSerializer.method(:serialize)),
        }
      end
    end
  end
end
