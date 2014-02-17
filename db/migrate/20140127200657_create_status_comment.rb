class CreateStatusComment < ActiveRecord::Migration
  def change
    create_table :status_comments do |t|
      t.integer :user_id, null: false
      t.integer :status_id, null: false
      t.text :message, null: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
