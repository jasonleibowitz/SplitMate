class AddApprovedToChoreHistory < ActiveRecord::Migration
  def change
  		add_column :chore_histories, :approved, :boolean
  end
end
