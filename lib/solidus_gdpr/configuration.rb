# frozen_string_literal: true

module SolidusGdpr
  # Configuration class for holding the gem's current configuration.
  class Configuration
    # @return [String] the exports mailer class
    attr_writer :exports_mailer_class

    # @return [Hash{String->Class}] a name-to-class mapping of data segments
    def segments
      @segments ||= {
        profile: DataSegments::ProfileSegment,
        orders: DataSegments::OrdersSegment,
      }
    end

    # Returns the serializers that will be used by the data segments and other serializers.
    #
    # Valid keys are +:address+, +:line_item+, +:order+, +:profile+ and +:shipment+.
    #
    # @return [Hash<String => Class>] the serializers to use
    def serializers
      {
        address: Serializers::AddressSerializer,
        line_item: Serializers::LineItemSerializer,
        order: Serializers::OrderSerializer,
        profile: Serializers::ProfileSerializer,
        shipment: Serializers::ShipmentSerializer,
      }
    end

    def exports_mailer_class
      @exports_mailer_class ||= 'Spree::GdprExportsMailer'
    end
  end
end
