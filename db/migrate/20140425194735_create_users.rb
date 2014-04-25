class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :points_balance
      t.integer :points_lifetime
      t.integer :completed_week_points
      t.integer :total_week_points
      t.integer :dollar_balance
      t.boolean :admin
      t.string :password_digest
      t.references :apartment
    end
  end
end
