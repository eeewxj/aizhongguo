class AddEyeToRecords < ActiveRecord::Migration
  def change
    add_column :records, :eye, :string
  end
end
