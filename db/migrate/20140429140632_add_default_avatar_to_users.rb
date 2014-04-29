class AddDefaultAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_avatar, :string
  end
end
