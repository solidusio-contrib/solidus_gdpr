# frozen_string_literal: true

module SolidusGdpr
  # @api private
  module SerializerAware
    private

    def serialize(object, with:)
      serializer = SolidusGdpr.configuration.serializers[with.to_sym].constantize

      if object.is_a?(Enumerable)
        object.map(&serializer.method(:serialize))
      else
        serializer.serialize(object)
      end
    end
  end
end
