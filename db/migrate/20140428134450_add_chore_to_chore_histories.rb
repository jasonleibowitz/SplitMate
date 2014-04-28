class AddChoreToChoreHistories < ActiveRecord::Migration
  def change
    add_reference :chore_histories, :chore, index: true
  end
end
