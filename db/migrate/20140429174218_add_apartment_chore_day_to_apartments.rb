class AddApartmentChoreDayToApartments < ActiveRecord::Migration
  def change
    add_column :apartments, :chore_assignment_day, :string
  end
end
