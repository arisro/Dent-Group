class Supplier < ActiveRecord::Base
	belongs_to :user
	has_many :supplier_comments

	def comments_count
		supplier_comments.where(deleted: false).length
	end
end