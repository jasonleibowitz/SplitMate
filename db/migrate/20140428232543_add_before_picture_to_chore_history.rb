class AddBeforePictureToChoreHistory < ActiveRecord::Migration
  def self.up
    change_table :chore_histories do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :chore_histories, :avatar
  end
end
