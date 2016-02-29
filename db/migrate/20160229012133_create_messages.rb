class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id,                   null: false
      t.integer :user_id,                     null: false
      t.text :content,                        null: false
      t.integer :status,                      default: 0

      t.timestamps
    end
  end
end
