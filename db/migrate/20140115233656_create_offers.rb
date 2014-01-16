class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
    	t.integer :user_id

    	t.string :title
    	t.text :body

    	t.integer :views

    	t.boolean :deleted, default: false

    	t.timestamps
    end
  end
end
