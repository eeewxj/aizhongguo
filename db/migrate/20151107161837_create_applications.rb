class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :verified
      t.boolean :attended

      t.timestamps
    end
  end
end
