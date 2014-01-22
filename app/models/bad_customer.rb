class BadCustomer < ActiveRecord::Base
	belongs_to :user
	has_many :bad_customer_comments

	default_scope { order('created_at DESC') }

	def comments_count
		bad_customer_comments.where(deleted: false).length
	end
end