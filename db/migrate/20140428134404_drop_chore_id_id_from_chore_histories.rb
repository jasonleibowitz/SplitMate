class DropChoreIdIdFromChoreHistories < ActiveRecord::Migration
  def change
    remove_column :chore_histories, :chore_id_id
  end
end
