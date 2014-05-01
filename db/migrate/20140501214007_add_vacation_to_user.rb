class AddVacationToUser < ActiveRecord::Migration
  def change
    add_column :users, :vacation, :boolean
  end
end
