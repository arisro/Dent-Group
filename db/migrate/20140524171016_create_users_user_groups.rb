class CreateUsersUserGroups < ActiveRecord::Migration
  def change
    create_table :users_user_groups do |t|
      t.integer :user_id
      t.integer :user_group_id

      t.timestamps
    end
  end
end
