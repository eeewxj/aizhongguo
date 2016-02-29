class AddEducationToResident < ActiveRecord::Migration
  def change
    add_column :residents, :education, :integer
  end
end
