class AddAttachmentImageToOffers < ActiveRecord::Migration
  def self.up
    change_table :offers do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :offers, :image
  end
end
