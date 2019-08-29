# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr::Configuration do
  subject(:configuration) { described_class.new }

  describe '#segments' do
    it 'returns the Solidus segments' do
      expected_keys = %i[profile orders]

      expect(configuration.segments).to match(Hash[expected_keys.map do |key|
        [key, an_instance_of(Class)]
      end])
    end
  end

  describe '#serializers' do
    it 'returns the serializer classes' do
      expected_keys = %i[address line_item order profile shipment]

      expect(configuration.serializers).to match(Hash[expected_keys.map do |key|
        [key, an_instance_of(Class)]
      end])
    end
  end
end
