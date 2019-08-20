# frozen_string_literal: true

module SolidusGdpr
  class DataEraser
    include SegmentProcessor

    def run
      with_each_segment.map do |key, segment|
        segment.erase
        key
      end
    end
  end
end
