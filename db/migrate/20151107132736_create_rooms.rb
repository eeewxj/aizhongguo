class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_number
      t.text :description
      t.integer :nursing_home_id

      t.timestamps
    end
  end
end
