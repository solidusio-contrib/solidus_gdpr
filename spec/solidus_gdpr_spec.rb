# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SolidusGdpr do
  subject(:solidus_gdpr) { described_class }

  describe '.configure' do
    it 'yields the configuration' do
      expect { |b| solidus_gdpr.configure(&b) }.to yield_with_args(described_class.configuration)
    end
  end
end
