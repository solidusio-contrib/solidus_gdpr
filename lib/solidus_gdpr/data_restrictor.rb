# frozen_string_literal: true

module SolidusGdpr
  class DataRestrictor
    include SegmentProcessor

    def run
      with_each_segment.map do |key, segment|
        segment.restrict_processing
        key
      end
    end

    def rollback
      with_each_segment.map do |key, segment|
        segment.resume_processing
        key
      end
    end
  end
end
