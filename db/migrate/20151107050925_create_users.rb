class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email,                  default: "", null: false
      t.string :password,               default: "", null: false
      t.string :name
      t.string :phone_number
      t.boolean :gender
      t.integer :age
      t.string :address
      t.string :work_unit
      t.integer :user_type
      t.text :self_description

      t.timestamps
    end
  end
end
