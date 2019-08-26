# frozen_string_literal: true

module SolidusGdpr
  # Configuration class for holding the gem's current configuration.
  class Configuration
    # @return [String] the exports mailer class
    attr_writer :exports_mailer_class

    # @return [Hash{String->Class}] a name-to-class mapping of data segments
    def segments
      @segments ||= {
        'profile' => DataSegments::ProfileSegment,
        'orders' => DataSegments::OrdersSegment,
      }
    end

    def exports_mailer_class
      @exports_mailer_class ||= 'Spree::GdprExportsMailer'
    end
  end
end
