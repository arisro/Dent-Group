class News < ActiveRecord::Base
	searchkick

	# searchkick stuff
	def should_index?
		!deleted?
  	end
	def search_data
		as_json only: [:title, :summary, :body]
	end
end
