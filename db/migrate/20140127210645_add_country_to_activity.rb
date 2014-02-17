class AddCountryToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :country, :string, limit: 3, null: false
  end
end
