class AddDollarValueToChores < ActiveRecord::Migration
  def change
    add_column :chores, :dollar_value, :integer
  end
end
