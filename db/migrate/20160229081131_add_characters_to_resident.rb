class AddCharactersToResident < ActiveRecord::Migration
  def change
    add_column :residents, :characters, :string
  end
end
