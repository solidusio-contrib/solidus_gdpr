# frozen_string_literal: true

module Spree
  class GdprExportsMailer < Spree::BaseMailer
    def export_email(user, export:)
      @user = user

      attachments["export-#{Time.zone.now.to_i}.zip"] = export

      mail(
        to: user.email,
        from: from_address(Spree::Store.default),
        subject: 'Your GDPR Data Export',
      )
    end
  end
end
