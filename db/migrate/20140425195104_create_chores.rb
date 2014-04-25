class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :name
      t.integer :points_value
      t.string :type
      t.timestamps
      t.datetime :date_completed
      t.text :comments
      t.boolean :rebuy
      t.references :roommate
      t.references :apartment
    end
  end
end
