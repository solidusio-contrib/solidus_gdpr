# frozen_string_literal: true

module SolidusGdpr
  module Serializers
    # @api private
    class BaseSerializer
      attr_reader :object

      class << self
        def serialize(object)
          new(object).as_json
        end
      end

      def initialize(object)
        @object = object
      end

      def as_json(*)
        fail NotImplementedError
      end
    end
  end
end
