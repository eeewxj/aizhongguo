class AddZoneIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :zone_id, :integer
  end
end
