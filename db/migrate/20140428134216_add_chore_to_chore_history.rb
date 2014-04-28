class AddChoreToChoreHistory < ActiveRecord::Migration
  def change
    add_reference :chore_histories, :chore_id, index: true
  end
end
