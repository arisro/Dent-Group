class AddAttachmentImageToSuppliers < ActiveRecord::Migration
  def self.up
    change_table :suppliers do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :suppliers, :image
  end
end
