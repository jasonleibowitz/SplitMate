class AddJsDateToChoreHistories < ActiveRecord::Migration
  def change
    add_column :chore_histories, :js_date, :integer
  end
end
