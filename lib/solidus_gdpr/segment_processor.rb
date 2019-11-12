# frozen_string_literal: true

# @api private
module SolidusGdpr
  module SegmentProcessor
    def self.included(klass)
      klass.send(:attr_accessor, :email)
    end

    def initialize(email)
      @email = email
    end

    private

    def with_each_segment
      Enumerator.new do |y|
        SolidusGdpr.configuration.segments.each_pair do |key, klass|
          y << [key, klass.constantize.new(email)]
        rescue NotImplementedError
          nil
        end
      end
    end
  end
end
