class Supplier < ActiveRecord::Base
	belongs_to :user

	has_many :supplier_comments

	# searchkick

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:name, :description, :website, :country, :city, :address]
	end

	def comments_count
		supplier_comments.where(deleted: false).length
	end
end