class CreatePickupSites < ActiveRecord::Migration
  def change
    create_table :pickup_sites do |t|
      t.string :name
      t.integer :project_id
      t.string :liaison
      t.string :phone_number
      t.datetime :meeting_time

      t.timestamps
    end
  end
end
