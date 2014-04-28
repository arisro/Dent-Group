class AddAttachmentImageToJobs < ActiveRecord::Migration
  def self.up
    change_table :jobs do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :jobs, :image
  end
end
