class CreateNewsCategories < ActiveRecord::Migration
  def change
    create_table :news_categories do |t|
      t.string :ident
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
