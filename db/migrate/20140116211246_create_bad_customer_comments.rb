class CreateBadCustomerComments < ActiveRecord::Migration
  def change
    create_table :bad_customer_comments do |t|
      t.integer :bad_customer_id
      t.integer :user_id
      t.text :body
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
