class ChangeZipcodeToStringOnApartments < ActiveRecord::Migration
  def change
    change_column :apartments, :zipcode, :string
  end
end
