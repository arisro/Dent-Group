class CreateNewsComments < ActiveRecord::Migration
  def change
    create_table :news_comments do |t|
      t.integer :news_id
      t.integer :user_id
      t.text :body
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
    add_index :news_comments, :news_id
  end
end
