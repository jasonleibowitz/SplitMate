class RenameRoomateOnChores < ActiveRecord::Migration
  def change
    rename_column :chores, :roommate_id, :user_id
  end
end
