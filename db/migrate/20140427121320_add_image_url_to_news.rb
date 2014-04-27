class AddImageUrlToNews < ActiveRecord::Migration
  def change
  	add_column :news, :image_url, :string
  end
end
