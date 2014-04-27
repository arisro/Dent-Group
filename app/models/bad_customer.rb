class BadCustomer < ActiveRecord::Base
	searchkick

	belongs_to :user
	has_many :bad_customer_comments

	default_scope { order('created_at DESC') }

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:name, :cnp, :message, :website_country]
	end

	def comments_count
		bad_customer_comments.where(deleted: false).length
	end
end