class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :user_id
      t.integer :resident_id
      t.integer :project_id
      t.text :desc

      t.timestamps
    end
  end
end
