class AddDefaultProfileToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :default_avatar, :string
  end
end
