# frozen_string_literal: true

module SolidusGdpr
  module Serializers
    # @api private
    class ShipmentSerializer < BaseSerializer
      def as_json(*)
        {
          tracking: object.tracking,
          number: object.number,
          shipped_at: object.shipped_at,
          adjustment_total: object.adjustment_total,
          additional_tax_total: object.additional_tax_total,
          promo_total: object.promo_total,
          included_tax_total: object.included_tax_total,
        }
      end
    end
  end
end
