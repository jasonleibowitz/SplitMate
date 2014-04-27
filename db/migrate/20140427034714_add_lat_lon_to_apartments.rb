class AddLatLonToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :latitute, :float
    add_column :apartments, :longitude, :float
  end
end
