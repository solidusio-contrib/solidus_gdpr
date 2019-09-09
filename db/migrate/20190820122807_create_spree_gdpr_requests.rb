# frozen_string_literal: true

class CreateSpreeGdprRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :spree_gdpr_requests do |t|
      t.integer :intent, null: false
      t.integer :user_id, null: false
      t.text :notes
      t.datetime :served_at
      t.string :processed_segments, array: true

      t.timestamps
    end
  end
end
