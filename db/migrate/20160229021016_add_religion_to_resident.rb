class AddReligionToResident < ActiveRecord::Migration
  def change
    add_column :residents, :religion, :string
    add_column :residents, :nursing_type, :integer
    add_column :residents, :mental_state, :string
    add_column :residents, :interests, :string
    add_column :residents, :tastes, :string
  end
end
