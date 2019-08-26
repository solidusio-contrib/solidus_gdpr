# frozen_string_literal: true

module SolidusGdpr
  # @api private
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'solidus_gdpr'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.to_prepare do
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/decorators/**/*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end
  end
end
