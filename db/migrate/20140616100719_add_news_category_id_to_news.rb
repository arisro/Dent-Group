class AddNewsCategoryIdToNews < ActiveRecord::Migration
  def change
    add_column :news, :category_id, :int
  end
end
