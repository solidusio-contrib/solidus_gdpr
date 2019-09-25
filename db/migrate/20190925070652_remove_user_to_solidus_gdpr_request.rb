# frozen_string_literal: true

class RemoveUserToSolidusGdprRequest < ActiveRecord::Migration[5.1]
  def change
    remove_column :spree_gdpr_requests, :user_id

    reversible do |dir|
      dir.down do
        ActiveRecord::Base.uncached do
          Spree::GdprRequest.all.find_each do |gdpr_request|
            user = Spree::User.find_by(email: gdpr_request.email)
            gdpr_request.update_columns(user: user) if user
          end
        end
      end
    end
  end
end
