class AddAttachmentAvatarToResidents < ActiveRecord::Migration
  def self.up
    change_table :residents do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :residents, :avatar
  end
end
