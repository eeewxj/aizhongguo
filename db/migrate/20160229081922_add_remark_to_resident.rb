class AddRemarkToResident < ActiveRecord::Migration
  def change
    add_column :residents, :remark, :string
  end
end
