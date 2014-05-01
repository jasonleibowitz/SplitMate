class AddChoreAssignedDateToChores < ActiveRecord::Migration
  def change
  	add_column :chores, :current_assigned_date, :date
  end
end
