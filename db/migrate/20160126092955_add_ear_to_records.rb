class AddEarToRecords < ActiveRecord::Migration
  def change
    add_column :records, :ear, :string
  end
end
