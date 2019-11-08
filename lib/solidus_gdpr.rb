# frozen_string_literal: true

require 'solidus_support'
require 'solidus_core'
require 'zip'

require 'solidus_gdpr/configuration'
require 'solidus_gdpr/segment_processor'
require 'solidus_gdpr/serializer_aware'
require 'solidus_gdpr/engine'
require 'solidus_gdpr/version'
require 'solidus_gdpr/data_eraser'
require 'solidus_gdpr/data_exporter'
require 'solidus_gdpr/data_exporter/assemble_archive'
require 'solidus_gdpr/data_exporter/prepare_files'
require 'solidus_gdpr/data_exporter/send_archive'
require 'solidus_gdpr/data_segments/base'
require 'solidus_gdpr/data_segments/orders_segment'
require 'solidus_gdpr/data_segments/profile_segment'
require 'solidus_gdpr/serializers/base_serializer'
require 'solidus_gdpr/serializers/address_serializer'
require 'solidus_gdpr/serializers/line_item_serializer'
require 'solidus_gdpr/serializers/order_serializer'
require 'solidus_gdpr/serializers/profile_serializer'
require 'solidus_gdpr/serializers/shipment_serializer'
require 'solidus_gdpr/data_restrictor'

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
