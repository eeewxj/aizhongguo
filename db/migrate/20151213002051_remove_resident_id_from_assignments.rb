class RemoveResidentIdFromAssignments < ActiveRecord::Migration
  def change
    remove_column :assignments, :resident_id, :integer
  end
end
