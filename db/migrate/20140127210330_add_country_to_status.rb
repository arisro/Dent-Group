class AddCountryToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :country, :string, limit: 3, null: false
  end
end
