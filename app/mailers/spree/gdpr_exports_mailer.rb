# frozen_string_literal: true

module Spree
  class GdprExportsMailer < Spree::BaseMailer
    def export_email(email, export:)
      @email = email

      attachments["export-#{Time.zone.now.to_i}.zip"] = export

      mail(
        to: email,
        from: from_address(Spree::Store.default),
        subject: 'Your GDPR Data Export',
      )
    end
  end
end
