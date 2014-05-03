class AddChatIsInvisibleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :chat_is_invisible, :boolean, default: false
  end
end
