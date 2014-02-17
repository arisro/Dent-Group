class CreateStatusPictures < ActiveRecord::Migration
  def change
    create_table :statuses_uploads do |t|
      t.integer :status_id, null: false
      t.integer :upload_id, null: false
    end
  end
end
