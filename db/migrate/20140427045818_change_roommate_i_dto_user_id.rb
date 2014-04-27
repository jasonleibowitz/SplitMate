class ChangeRoommateIDtoUserId < ActiveRecord::Migration
  def change
  	rename_column :approvals, :roommate_id, :user_id 
  end
end
