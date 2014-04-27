class AddAttachmentAvatarToApartments < ActiveRecord::Migration
  def self.up
    change_table :apartments do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :apartments, :avatar
  end
end
