class AddFromUserIdAndToUserIdToActivities < ActiveRecord::Migration
  def change
  	remove_column :activities, :user_id
  	add_column :activities, :from_user_id, :integer, null: false
  	add_column :activities, :to_user_id, :integer

	add_index :activities, :from_user_id
	add_index :activities, :to_user_id
  end
end
