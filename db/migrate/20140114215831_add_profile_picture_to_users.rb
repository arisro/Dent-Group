class AddProfilePictureToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_picture, :string
    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
  end
end
