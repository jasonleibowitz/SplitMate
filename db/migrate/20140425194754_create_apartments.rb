class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :name
      t.string :street
      t.string :apt
      t.integer :zipcode
    end
  end
end
