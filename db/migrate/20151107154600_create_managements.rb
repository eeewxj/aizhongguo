class CreateManagements < ActiveRecord::Migration
  def change
    create_table :managements do |t|
      t.integer :nursing_home_id
      t.integer :user_id

      t.timestamps
    end
  end
end
