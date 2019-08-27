# frozen_string_literal: true

module SolidusGdpr
  module Serializers
    # @api private
    class LineItemSerializer < BaseSerializer
      def as_json(*)
        {
          variant: {
            name: object.variant.name
          },
          quantity: object.quantity,
          price: object.price,
          adjustment_total: object.adjustment_total,
          additional_tax_total: object.additional_tax_total,
          promo_total: object.promo_total,
          included_tax_total: object.included_tax_total,
          total: object.total,
        }
      end
    end
  end
end
