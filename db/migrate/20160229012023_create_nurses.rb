class CreateNurses < ActiveRecord::Migration
  def change
    create_table :nurses do |t|
      t.string :name
      t.date :birthday
      t.boolean :gender
      t.string :phone
      t.string :hometown
      t.string :home
      t.integer :education
      t.string :previous_job
      t.string :religion
      t.string :interests
      t.text :background
      t.text :nursing
      t.integer :nursing_home_id

      t.timestamps
    end
  end
end
