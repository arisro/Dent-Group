class AddImageColumnsToNews < ActiveRecord::Migration
  def change
	def self.up
		add_attachment :news, :image
	end

	def self.down
		remove_attachment :news, :image
	end
  end
end
