class RenameChoreIdToChoreHistoryId < ActiveRecord::Migration
  def change
  	rename_column :approvals, :chore_id, :chore_history_id
  end
end
