class BadCustomer < ActiveRecord::Base
	belongs_to :user
	has_many :bad_customer_comments
end