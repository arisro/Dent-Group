class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.text :body

      t.timestamps
    end

    add_index :chat_messages, :from_user_id
    add_index :chat_messages, :to_user_id
  end
end
