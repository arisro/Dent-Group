class CreateHomepageMessages < ActiveRecord::Migration
  def change
    create_table :homepage_messages do |t|
    	t.string :title
		t.text :body
		t.integer :views, default: 0
		t.integer :user_id
		t.datetime :published_at
		t.boolean :deleted, null: false, default: false
		t.string :website_country, limit: 3

		t.timestamps
    end
  end
end
