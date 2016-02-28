class ChangeColumn < ActiveRecord::Migration
  def change
    change_column_default :users, :gender, false
  end
end
