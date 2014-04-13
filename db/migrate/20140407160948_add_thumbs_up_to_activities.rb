class AddThumbsUpToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :thumbs_up, :integer, null: false, default: 0
  end
end
