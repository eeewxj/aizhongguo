class AddZoneIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :zone_id, :integer
  end
end
