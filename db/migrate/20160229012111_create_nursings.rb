class CreateNursings < ActiveRecord::Migration
  def change
    create_table :nursings do |t|
      t.integer :nurse_id
      t.integer :resident_id

      t.timestamps
    end
  end
end
