class FixNewsCategoryIdColumn < ActiveRecord::Migration
  def change
    remove_column :news, :category_id
    add_column :news, :news_category_id, :integer
  end
end
