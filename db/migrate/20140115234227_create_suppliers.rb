class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
    	t.integer :user_id

    	t.string :name
    	t.text :description

    	t.string :email
    	t.string :phone
    	t.string :website

    	t.string :country
    	t.string :city
    	t.text :address

    	t.integer :views

    	t.boolean :deleted, default: false

    	t.timestamps
    end
  end
end
