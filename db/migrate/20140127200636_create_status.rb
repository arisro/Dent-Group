class CreateStatus < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id, null: false
      t.text :message, null: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
