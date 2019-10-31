# frozen_string_literal: true

class AddEmailFieldToSolidusGdprRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_gdpr_requests, :email, :string

    reversible do |dir|
      dir.up do
        ActiveRecord::Base.uncached do
          Spree::GdprRequest.all.find_each do |gdpr_request|
            gdpr_request.update_columns(
              email: Spree::User.find(
                gdpr_request.user_id
              ).email
            )
          end
        end
      end
    end
  end
end
