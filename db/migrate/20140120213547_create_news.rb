class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :summary
      t.text :body
      t.integer :views, default: 0
      t.integer :user_id
      t.datetime :published_at
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
  end
end
