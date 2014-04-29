class AddAfterPictureToChoreHistory < ActiveRecord::Migration
  def self.up
    change_table :chore_histories do |t|
      t.attachment :after_picture
    end
  end

  def self.down
    drop_attached_file :chore_histories, :after_picture
  end
end
