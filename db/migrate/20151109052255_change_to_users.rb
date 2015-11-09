class ChangeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :user_type, :integer
    add_column :users, :user_type, :integer, default: 2
  end
end
