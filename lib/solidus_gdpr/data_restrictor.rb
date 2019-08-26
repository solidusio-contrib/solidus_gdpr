# frozen_string_literal: true

module SolidusGdpr
  # Restricts or resumes processing for a user's data segments.
  class DataRestrictor
    include SegmentProcessor

    # Restricts processing of the user's data segments.
    #
    # Runs {DataSegments::Base#restrict_processing} on each data segment. If a data segment's
    # {DataSegments::Base#restrict_processing} raises a +NotImplementedError+, then that segment
    # is ignored.
    #
    # @return [Array<String>] the names of the restricted data segments
    def run
      with_each_segment.map do |key, segment|
        segment.restrict_processing
        key
      end
    end

    # Resumes processing of the user's data segments.
    #
    # Runs {DataSegments::Base#resume_processing} on each data segment. If a data segment's
    # {DataSegments::Base#resume_processing} raises a +NotImplementedError+, then that segment
    # is ignored.
    #
    # @return [Array<String>] the names of the resumed data segments
    def rollback
      with_each_segment.map do |key, segment|
        segment.resume_processing
        key
      end
    end
  end
end
