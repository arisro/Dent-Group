class AddWebsiteCountryToAllContent < ActiveRecord::Migration
  def change
    add_column :jobs, :website_country, :string, limit: 3
    add_column :offers, :website_country, :string, limit: 3
    add_column :suppliers, :website_country, :string, limit: 3
    add_column :news, :website_country, :string, limit: 3
    add_column :bad_customers, :website_country, :string, limit: 3
  end
end
