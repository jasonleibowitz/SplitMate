class AddApprovalRatioToChoreHistory < ActiveRecord::Migration
  def change
  	add_column :chore_histories, :approval_ratio, :integer
  end
end
