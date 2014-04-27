class Offer < ActiveRecord::Base
	self.inheritance_column = nil

	searchkick
	
	belongs_to :user

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:title, :body, :summary, :website_country, :created_at]
	end
end