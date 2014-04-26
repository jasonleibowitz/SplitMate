class RemoveColumnsFromChores < ActiveRecord::Migration
  def change
    remove_column :chores, :type
    remove_column :chores, :date_completed
    remove_column :chores, :comments
    remove_column :chores, :rebuy
    add_column :chores, :due_date, :date

  end
end
