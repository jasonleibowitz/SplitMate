class AddCurrentDueDateToChores < ActiveRecord::Migration
  def change
    add_column :chores, :current_due_date, :date
  end
end
