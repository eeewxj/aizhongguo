class ChangeToApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :verified, :boolean
    remove_column :applications, :attended, :boolean
    add_column :applications, :verified, :boolean, default: false
    add_column :applications, :attended, :boolean, default: false
  end
end
