# frozen_string_literal: true

module SolidusGdpr
  class DataExporter
    # @api private
    class PrepareFiles
      include SegmentProcessor

      def call
        files = {}

        segments = with_each_segment.map do |segment_name, segment|
          files["#{segment_name}.json"] = segment.export.to_json
          segment_name
        end

        [segments, files]
      end
    end
  end
end
