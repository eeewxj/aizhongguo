class AddPreviousJobToResident < ActiveRecord::Migration
  def change
    add_column :residents, :previous_job, :string
  end
end
