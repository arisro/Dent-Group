class AddCountryCityPhoneSkypeYmessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :phone, :string
    add_column :users, :skype, :string
    add_column :users, :yahoo, :string
  end
end
