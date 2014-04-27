class NewsComment < ActiveRecord::Base
	belongs_to :user
	belongs_to :news

	default_scope order('created_at DESC')
end
