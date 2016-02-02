class AddNoseToRecords < ActiveRecord::Migration
  def change
    add_column :records, :nose, :string
  end
end
