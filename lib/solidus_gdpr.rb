# frozen_string_literal: true

require 'solidus_core'
require 'zeitwerk'
require 'zip'

Zeitwerk::Loader.for_gem.tap do |loader|
  loader.ignore("#{__dir__}/solidus_gdpr/factories.rb")
  loader.ignore("#{__dir__}/generators")

  loader.setup
  loader.eager_load
end

module SolidusGdpr
  class << self
    # Returns the current configuration object.
    #
    # @return [Configuration]
    def configuration
      @configuration ||= Configuration.new
    end

    # Yields the configuration object.
    #
    # @yield [configuration] passes the configuration to the block
    #
    # @yieldparam [Configuration] configuration the configuration object
    def configure
      yield configuration
    end
  end
end
