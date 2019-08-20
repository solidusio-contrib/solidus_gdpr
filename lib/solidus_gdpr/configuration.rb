# frozen_string_literal: true

module SolidusGdpr
  class Configuration
    def segments
      @segments ||= {
        'profile' => DataSegments::ProfileSegment,
        'orders' => DataSegments::OrdersSegment,
      }
    end
  end
end
