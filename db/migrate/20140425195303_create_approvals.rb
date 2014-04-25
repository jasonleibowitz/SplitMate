class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.references :chore
      t.references :roommate
      t.integer :value
    end
  end
end
