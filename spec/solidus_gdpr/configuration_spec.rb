# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Configuration do
  subject(:configuration) { described_class.new }

  describe '#segments' do
    it 'returns the Solidus segments' do
      segments = configuration.segments.transform_values(&:constantize)
      expect(segments.values).to all(be < SolidusGdpr::DataSegments::Base)
    end

    it 'can be altered' do
      configuration.segments[:profile] = 'test_segment'
      expect(configuration.segments[:profile]).to eq('test_segment')
    end
  end

  describe '#serializers' do
    it 'returns the serializer classes' do
      serializers = configuration.serializers.transform_values(&:constantize)
      expect(serializers.values).to all(be < SolidusGdpr::Serializers::BaseSerializer)
    end

    it 'can be altered' do
      configuration.serializers[:profile] = 'test_serializer'
      expect(configuration.serializers[:profile]).to eq('test_serializer')
    end
  end

  describe '#exports_mailer_class' do
    it 'can be altered' do
      configuration.exports_mailer_class = 'test_class'
      expect(configuration.exports_mailer_class).to eq('test_class')
    end
  end
end
