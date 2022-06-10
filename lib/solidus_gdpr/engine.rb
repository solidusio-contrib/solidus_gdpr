# frozen_string_literal: true

require 'spree/core'

module SolidusGdpr
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace Spree

    engine_name 'solidus_gdpr'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'solidus_gdpr.pub_sub' do |app|
      unless SolidusSupport::LegacyEventCompat.using_legacy?
        app.reloader.to_prepare do
          ::Spree::Bus.register(:'gdpr_request_created')
          ::Spree::Bus.register(:'gdpr_request_served')
        end
      end
    end
  end
end
