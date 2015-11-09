class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :name
      t.boolean :gender
      t.date :birthday
      t.text :condition
      t.string :phone_number
      t.string :contact
      t.string :contact_phone_number
      t.integer :room_id

      t.timestamps
    end
  end
end
