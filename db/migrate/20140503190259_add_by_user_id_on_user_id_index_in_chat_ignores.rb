class AddByUserIdOnUserIdIndexInChatIgnores < ActiveRecord::Migration
  def change
  	add_index :chat_ignores, [:by_user_id, :on_user_id], unique: true
  end
end
