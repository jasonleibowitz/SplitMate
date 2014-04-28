class ChangeDuedateDataTypeOnChores < ActiveRecord::Migration
  def change
    change_column :chores, :due_date, :string
  end
end
