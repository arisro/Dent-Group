class AddDeletedAndWebsiteCountryToStaticPages < ActiveRecord::Migration
  def change
  	add_column :static_pages, :website_country, :string, limit: 3
  	add_column :static_pages, :deleted, :boolean, null: false, default: false
  end
end
