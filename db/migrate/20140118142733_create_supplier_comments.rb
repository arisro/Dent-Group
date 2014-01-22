class CreateSupplierComments < ActiveRecord::Migration
  def change
    create_table :supplier_comments do |t|
      t.integer :user_id
      t.integer :supplier_id
      t.text :body
      t.boolean :deleted

      t.timestamps
    end
  end
end
