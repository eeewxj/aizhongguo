class CreateResidents < ActiveRecord::Migration
  def change
    create_table :residents do |t|
      t.string :name
      t.boolean :gender
      t.date :birthday
      t.string :home_address
      t.text :condition
      t.string :phone_number
      t.string :contact
      t.string :contact_phone_number

      t.timestamps
    end
  end
end
