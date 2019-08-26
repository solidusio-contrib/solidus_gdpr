# frozen_string_literal: true

module SolidusGdpr
  # Erases all configured data segments for a given user.
  class DataEraser
    include SegmentProcessor

    # Runs the data erasure process.
    #
    # Walks through the configured data segments, calling {DataSegments::Base#erase} on each one.
    # If {DataSegments::Base#erase} raises a +NotImplementedError+, the data segment is ignored.
    #
    # @return [Array<String>] the names of the erased data segments
    def run
      with_each_segment.map do |key, segment|
        segment.erase
        key
      end
    end
  end
end
