class BadCustomerComment < ActiveRecord::Base
	belongs_to :user
	belongs_to :bad_customer

	default_scope order('created_at DESC')
end
