class AddHomeToResident < ActiveRecord::Migration
  def change
    add_column :residents, :home, :string
  end
end
