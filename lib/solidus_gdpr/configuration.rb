# frozen_string_literal: true

module SolidusGdpr
  # Configuration class for holding the gem's current configuration.
  class Configuration
    # @return [String] the exports mailer class
    attr_writer :exports_mailer_class

    # @return [Hash{Symbol => String}] a name-to-class mapping of data segments
    def segments
      @segments ||= {
        profile: 'SolidusGdpr::DataSegments::ProfileSegment',
        orders: 'SolidusGdpr::DataSegments::OrdersSegment',
      }
    end

    # Returns the serializers that will be used by the data segments and other serializers.
    #
    # Valid keys are +:address+, +:line_item+, +:order+, +:profile+ and +:shipment+.
    #
    # @return [Hash{Symbol => String}] the serializers to use
    def serializers
      @serializers ||= {
        address: 'SolidusGdpr::Serializers::AddressSerializer',
        line_item: 'SolidusGdpr::Serializers::LineItemSerializer',
        order: 'SolidusGdpr::Serializers::OrderSerializer',
        profile: 'SolidusGdpr::Serializers::ProfileSerializer',
        shipment: 'SolidusGdpr::Serializers::ShipmentSerializer',
      }
    end

    def exports_mailer_class
      @exports_mailer_class ||= 'Spree::GdprExportsMailer'
    end
  end
end
