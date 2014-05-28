class AddUserGroupIdToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :user_group_id, :integer
  end
end
