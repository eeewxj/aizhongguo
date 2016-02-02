class AddMindToRecords < ActiveRecord::Migration
  def change
    add_column :records, :mind, :string
  end
end
