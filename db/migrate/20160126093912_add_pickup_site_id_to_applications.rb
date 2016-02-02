class AddPickupSiteIdToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :pickup_site_id, :integer
  end
end
