class CreateNursingHomes < ActiveRecord::Migration
  def change
    create_table :nursing_homes do |t|
      t.string :name
      t.string :address
      t.string :contact
      t.string :phone_number
      t.text :description
      t.string :website

      t.timestamps
    end
  end
end
