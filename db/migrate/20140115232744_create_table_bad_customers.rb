class CreateTableBadCustomers < ActiveRecord::Migration
  def change
    create_table :bad_customers do |t|
    	t.integer :user_id

    	t.string :name
    	t.string :cnp

    	t.text :message

    	t.boolean :deleted, default: false

    	t.timestamps
    end
  end
end
