class AddUserGroupIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :user_group_id, :integer
  end
end
