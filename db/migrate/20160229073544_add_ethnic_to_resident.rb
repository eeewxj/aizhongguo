class AddEthnicToResident < ActiveRecord::Migration
  def change
    add_column :residents, :ethnic, :string
  end
end
