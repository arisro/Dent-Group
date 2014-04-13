class AddUserIdToStaticPages < ActiveRecord::Migration
  def change
    add_column :static_pages, :user_id, :integer
  end
end
