# frozen_string_literal: true

SolidusGdpr.configure do |config|
  # Override the mailer used to send data exports.
  # config.exports_mailer_class = Spree::GdprExportsMailer

  # Add a new data segments or override the existing segments.
  # config.segments[:reviews] = ReviewsSegment

  # Override a serializer used for data exports. Valid keys
  # are :address, :line_item, :order, :profile, :shipment.
  # config.serializers[:profile] = ProfileSerializer
end
