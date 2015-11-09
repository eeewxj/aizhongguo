class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :nursing_home_id
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.integer :staff_number
      t.integer :contact_id

      t.timestamps
    end
  end
end
