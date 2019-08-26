# frozen_string_literal: true

# @api private
module SegmentProcessor
  def self.included(klass)
    klass.attr_accessor :user
  end

  def initialize(user)
    @user = user
  end

  private

  def with_each_segment
    Enumerator.new do |y|
      SolidusGdpr.configuration.segments.each_pair do |key, klass|
        y << [key, klass.new(user)]
      rescue NotImplementedError
        nil
      end
    end
  end
end
