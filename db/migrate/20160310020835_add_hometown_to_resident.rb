class AddHometownToResident < ActiveRecord::Migration
  def change
    add_column :residents, :hometown, :string
  end
end
