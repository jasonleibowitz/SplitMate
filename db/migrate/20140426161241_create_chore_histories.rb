class CreateChoreHistories < ActiveRecord::Migration
  def change
    create_table :chore_histories do |t|
      t.string :name
      t.integer :points_value
      t.timestamps
      t.text :comments
      t.references :user
      t.references :apartment
    end
  end
end
