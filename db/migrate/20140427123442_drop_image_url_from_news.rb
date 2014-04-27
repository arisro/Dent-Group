class DropImageUrlFromNews < ActiveRecord::Migration
  def change
  	remove_column :news, :image_url
  end
end
