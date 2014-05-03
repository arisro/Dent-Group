class CreateChatIgnores < ActiveRecord::Migration
  def change
    create_table :chat_ignores do |t|
      t.integer :by_user_id, null: false
      t.integer :on_user_id, null: false
    end

    add_index :chat_ignores, :by_user_id
    add_index :chat_ignores, :on_user_id
  end
end
