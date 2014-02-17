class ChangeStatusPictures < ActiveRecord::Migration
  def change
  	drop_table :status_pictures

    create_table :pictures_statuses do |t|
      t.integer :picture_id, null: false
      t.integer :status_id, null: false
    end
  end
end
