# frozen_string_literal: true

module SolidusGdpr
  class Configuration
    attr_writer :exports_mailer_class

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
