class AddBodyToRecords < ActiveRecord::Migration
  def change
    add_column :records, :body, :string
  end
end
