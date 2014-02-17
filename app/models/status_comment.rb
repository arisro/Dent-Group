class StatusComment < ActiveRecord::Base
	belongs_to :user
	belongs_to :status

	default_scope where('deleted = 0')
end