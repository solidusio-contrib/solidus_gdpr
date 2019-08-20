# frozen_string_literal: true

module SolidusGdpr
  class DataExporter
    include SegmentProcessor

    def run
      Hash[with_each_segment.map do |key, segment|
        [key, segment.export]
      end]
    end
  end
end
