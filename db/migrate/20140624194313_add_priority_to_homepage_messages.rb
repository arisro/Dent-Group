class AddPriorityToHomepageMessages < ActiveRecord::Migration
  def change
    add_column :homepage_messages, :priority, :integer, default: 1, null: false
  end
end
