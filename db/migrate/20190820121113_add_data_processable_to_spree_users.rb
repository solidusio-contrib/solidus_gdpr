# frozen_string_literal: true

class AddDataProcessableToSpreeUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_users, :data_processable, :boolean, null: false, default: true
  end
end
