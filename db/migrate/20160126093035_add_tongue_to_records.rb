class AddTongueToRecords < ActiveRecord::Migration
  def change
    add_column :records, :tongue, :string
  end
end
