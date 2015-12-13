class RemoveNursingHomeIdFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :nursing_home_id, :integer
  end
end
