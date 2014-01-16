class BadCustomerComment < ActiveRecord::Base
	belongs_to :user
	belongs_to :bad_customer
end
