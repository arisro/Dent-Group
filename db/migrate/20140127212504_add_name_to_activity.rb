class AddNameToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :name, :string, null: false

	add_index :activities, :subject_id
	add_index :activities, :subject_type
	add_index :activities, :user_id
  end
end
