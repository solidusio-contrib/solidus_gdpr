# frozen_string_literal: true

Spree::Backend::Config.configure do |config|
  config.menu_items << config.class::MenuItem.new(
    [:gdpr],
    'user-secret',
    condition: -> { can?(:admin, Spree::User) },
    url: :admin_gdpr_requests_path
  )
end
