class AddApprovalPointsToChoresHistory < ActiveRecord::Migration
  def change
  	add_column :chore_histories, :approval_points, :integer
  end
end
