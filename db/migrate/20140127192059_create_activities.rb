class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :subject, polymorphic: true, index: true
      t.integer :user_id

      t.timestamps
    end
  end
end
