class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.integer :nursing_home_id
      t.text :description

      t.timestamps
    end
  end
end
