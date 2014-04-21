class StatusComment < ActiveRecord::Base
	belongs_to :user
	belongs_to :status

	COMMENTS_PER_PAGE = 3

	default_scope where('deleted = 0').order('created_at DESC')
end